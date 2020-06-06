//
//  PersistencyHelper.swift
//  Bullseye
//
//  Created by Eric Golovin on 10.04.2020.
//  Copyright © 2020 Eric Golovin. All rights reserved.
//

import UIKit

class PersistencyHelper {
    static func saveUserData(_ data: UserData) {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode([data])
            try data.write(to: dataFilePath())
        } catch {
            print("Error encoding data: \(error.localizedDescription)")
        }
    }
    
    static func saveUserImage(_ image: UIImage) {
        if let data = image.jpegData(compressionQuality:  1.0) {
            do {
                try data.write(to: imageFilePath())
                print("saved image")
            } catch {
                print("Error encoding image:", error)
            }
        }
    }
    
    static func loadUserData() -> UserData? {
        var userData = Array<UserData>()
        if let data = try? Data(contentsOf: dataFilePath()) {
            let decoder = PropertyListDecoder()
            do {
                userData = try decoder.decode([UserData].self, from: data)
            } catch {
                print("Error decoding item array: \(error.localizedDescription)")
            }
        } else {
            return nil
        }
        return userData[0]
    }
    
    static func loadProfileImage() -> UIImage {
        var profileImage = UIImage()
        if let data = UIImage(contentsOfFile: imageFilePath().path) {
            profileImage = data
        }
        return profileImage
    }
    
    static func removeData() {
        let fileManager = FileManager.default
        
        do {
            try fileManager.removeItem(at: dataFilePath())
            try fileManager.removeItem(at: imageFilePath())
        } catch {
            print("Error deleting files: \(error.localizedDescription)")
        }
    }
    
    static func dataFilePath() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0].appendingPathComponent("UserData.plist")
    }
    
    static func imageFilePath() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0].appendingPathComponent("UserProfile.jpeg")
    }
}
