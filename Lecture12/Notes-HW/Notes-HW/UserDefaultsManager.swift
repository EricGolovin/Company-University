//
//  UserDefaultsManager.swift
//  Notes-HW
//
//  Created by Eric Golovin on 7/9/20.
//

import UIKit

class UserDefaultsManager {
        
    static func loadUserLogins() -> [String]? {
        let defaults = UserDefaults.standard
        return defaults.array(forKey: "notes.companyHW.userLogins") as? [String]
    }
    
    static func loadUserImageURLs() -> [String]? {
        let defaults = UserDefaults.standard
        return defaults.array(forKey: "notes.companyHW.userImageURLs") as? [String]
    }
    
    static func addUser(login: String, image: UIImage) {
        let defaults = UserDefaults.standard
        guard let imageURL = saveImage(image, with: login)?.absoluteString else {
            return
        }
        if var loadedLogins = loadUserLogins(),
           var loadedImageURLs = loadUserImageURLs() {
            loadedLogins.append(login)
            loadedImageURLs.append(imageURL)
            
            defaults.setValue(loadedLogins, forKey: "notes.companyHW.userLogins")
            defaults.setValue(loadedImageURLs, forKey: "notes.companyHW.userImageURLs")
        } else {
            defaults.setValue([login], forKey: "notes.companyHW.userLogins")
            defaults.setValue([imageURL], forKey: "notes.companyHW.userImageURLs")
        }
    }
    
    static func saveImage(_ image: UIImage, with loginName: String) -> URL? {
        if let data = image.jpegData(compressionQuality: 1.0) {
            let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let url = documents.appendingPathComponent("\(loginName).jpeg")

            do {
                try data.write(to: url)
            } catch {
                print("Unable to Write Data to Disk (\(error))")
            }
            return url
        }
        return nil
    }
    
    static func loadImage(from url: URL) -> UIImage? {
        do {
            let imageData = try Data(contentsOf: url)
            let image = UIImage(data: imageData)
            return image
        } catch {
            print("Unable to Load Data from Disk (\(error))")
        }
        return nil
    }
}
