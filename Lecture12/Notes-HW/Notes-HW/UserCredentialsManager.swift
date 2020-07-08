//
//  UserCredentialsManager.swift
//  Notes-HW
//
//  Created by Eric Golovin on 7/9/20.
//

import Foundation


struct Credentials {
    var username: String
    var password: String
}

enum KeychainError: Error {
    case noPassword
    case userAlreadyExist
    case unexpectedPasswordData
    case unhandledError(status: OSStatus)
}



class UserCredentialsManager {
    
    private var userCredentials: Credentials?
    
    func saveNewUser(username: String, password: String) {
        userCredentials = Credentials(username: username, password: password)
        
        do {
            try save()
        } catch {
            print("\(error): \(error.localizedDescription)")
        }
    }
    
    private func save() throws {
        guard let username = userCredentials?.username,
              let password = userCredentials?.password.data(using: String.Encoding.utf8) else {
            fatalError("UserCredentials are nil")
        }
        
        if load(for: username) != nil {
            throw KeychainError.userAlreadyExist
        }
        
        UserDefaultsManager.addLogin(username)
        
        let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                    kSecAttrCreator as String: username,
                                    kSecValueData as String: password]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        guard status == errSecSuccess else { throw KeychainError.unhandledError(status: status) }
    }
    
    func load(for userName: String) -> String? {
        let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                    kSecMatchLimit as String: kSecMatchLimitOne,
                                    kSecAttrCreator as String: userName,
                                    kSecReturnAttributes as String: true,
                                    kSecReturnData as String: true]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        guard status != errSecItemNotFound else { return nil/*throw KeychainError.noPassword*/ }
        guard status == errSecSuccess else { return nil/*throw KeychainError.unhandledError(status: status)*/ }
        
        guard let existingItem = item as? [String : Any],
              let passwordData = existingItem[kSecValueData as String] as? Data,
              let password = String(data: passwordData, encoding: String.Encoding.utf8),
              let accountName = existingItem[kSecAttrCreator as String] as? String else {
            return nil
//            throw KeychainError.unexpectedPasswordData
        }
        return "\(accountName) : \(password)"
    }
    
}
