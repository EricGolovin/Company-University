//
//  UserCredentialsManager.swift
//  Notes-HW
//
//  Created by Eric Golovin on 7/9/20.
//

import UIKit


struct Credentials {
    var username: String
    var password: String
    var profileImage: UIImage
}

class UserCredentialsManager {
    
    private var userCredentials: Credentials?
    
    func saveNewUser(username: String, password: String, userImage: UIImage, completion: ((Bool)->())? = nil) {
        userCredentials = Credentials(username: username, password: password, profileImage: userImage)
        
        if let completion = completion {
            completion(save())
        } else {
            let _ = save()
        }
    }
    
    func loadUser(with data: Credentials, completion: (Bool)->()) {
        completion(load(login: data.username, password: data.password))
    }
    
    private func save() -> Bool {
        guard let login = userCredentials?.username,
              let password = userCredentials?.password.data(using: String.Encoding.utf8),
              let profileImage = userCredentials?.profileImage else {
            fatalError("UserCredentials are nil")
        }
        
        do {
            try KeychainManager.save(login: login, password: password)
        } catch {
            print("\(error): \(error.localizedDescription)")
            return false
        }
        
        UserDefaultsManager.manager.addUser(login: login, image: profileImage)
        
        return true
    }
    
    private func load(login: String, password: String) -> Bool {
        do {
            try KeychainManager.load(login: login, password: password)
        } catch {
            print("\(error): \(error.localizedDescription)")
            return false
        }
        return true
    }
    
}
