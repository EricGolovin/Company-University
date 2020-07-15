//
//  KeychainManager.swift
//  Notes-HW
//
//  Created by Eric Golovin on 7/15/20.
//

import Foundation

protocol CredentialProtocol {
    static func save(login: String, password: Data) throws
    static func load(login: String, password: String) throws
}

enum KeychainError: Error {
    case noPassword
    case wrongPassword
    case duplicateData
    case unexpectedPasswordData
    case unhandledError(status: OSStatus)
}

struct KeychainManager: CredentialProtocol {
    
    static func save(login: String, password: Data) throws {
        let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                    kSecAttrAccount as String: login,
                                    kSecValueData as String: password]
        let status = SecItemAdd(query as CFDictionary, nil)
        
        switch status {
        case errSecSuccess:
            print("UserCredentials saved")
        case errSecDuplicateItem:
            throw KeychainError.duplicateData
        default:
            throw KeychainError.unhandledError(status: status)
        }
    }
    
    static func load(login: String, password: String) throws {
        let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                    kSecMatchLimit as String: kSecMatchLimitOne,
                                    kSecAttrAccount as String: login,
                                    kSecReturnAttributes as String: true,
                                    kSecReturnData as String: true]
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        switch status {
        case errSecSuccess:
            print("UserCredentials found")
        case errSecItemNotFound:
            throw KeychainError.noPassword
        default:
            throw KeychainError.unhandledError(status: status)
        }
        
        guard let existingItem = item as? [String : Any],
            let passwordData = existingItem[kSecValueData as String] as? Data,
            let savedPassword = String(data: passwordData, encoding: String.Encoding.utf8) else {
                throw KeychainError.unexpectedPasswordData
        }
        
        if password == savedPassword {
            print("Password verification completed")
        } else {
            throw KeychainError.wrongPassword
        }
    }
    
    static func delete(login: String) throws {
        let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                    kSecAttrAccount as String: login]
        
        let status = SecItemDelete(query as CFDictionary)
        guard status == errSecSuccess || status == errSecItemNotFound else { throw KeychainError.unhandledError(status: status) }
    }
}
