//
//  UserDefaultsManager.swift
//  Notes-HW
//
//  Created by Eric Golovin on 7/9/20.
//

import Foundation

class UserDefaultsManager {
    
    static func loadLogins() -> [String]? {
        let defaults = UserDefaults.standard
        return defaults.array(forKey: "notes.companyHW.userLogins") as? [String]
    }
    
    static func addLogin(_ login: String) {
        let defaults = UserDefaults.standard
        
        if var loadedLogins = loadLogins() {
            loadedLogins.append(login)
            defaults.setValue(loadedLogins, forKey: "notes.companyHW.userLogins")
        } else {
            defaults.setValue([login], forKey: "notes.companyHW.userLogins")
        }
    }
}
