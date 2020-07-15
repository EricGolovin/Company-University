//
//  UserDefaultsManager.swift
//  Notes-HW
//
//  Created by Eric Golovin on 7/9/20.
//

import UIKit

class UserDefaultsManager {
    
    static let manager = UserDefaultsManager()
    private let defaults = UserDefaults.standard
    
    private init() {}
    
    private let loginsIdentifier = "notes.companyHW.userLogins"
    private let imagesKeyIdentifier = "notes.companyHW.userImageURLs"
    
    func addUser(login: String, image: UIImage) {
        guard let imageURL = saveImage(image, with: login)?.absoluteString else {
            return
        }
        if var loadedLogins = loadUserLogins(),
            var loadedImageURLs = loadUserImageURLs() {
            loadedLogins.append(login)
            loadedImageURLs.append(imageURL)
            
            defaults.setValue(loadedLogins, forKey: loginsIdentifier)
            defaults.setValue(loadedImageURLs, forKey: imagesKeyIdentifier)
        } else {
            defaults.setValue([login], forKey: loginsIdentifier)
            defaults.setValue([imageURL], forKey: imagesKeyIdentifier)
        }
    }
    
    func loadUsers() -> (logins: [String], images: [UIImage])? {
        guard let userLogins = loadUserLogins(),
            let userImageURLs = loadUserImageURLs(),
            let userImages = (userImageURLs.map { self.loadImage(from: URL(string: $0)!) }) as? [UIImage] else {
                print("Error: Cannot load users data")
                return nil
        }
        
        
        print(userLogins)
        print(userImageURLs)
        
        return (userLogins, userImages)
    }
    
    func deleleAllUsers() {
        guard let imageURLs = defaults.value(forKey: imagesKeyIdentifier) as? [String] else {
            print("Cannot delete images: no image urls found")
            return
        }
        let fileManager = FileManager.default
        for url in imageURLs {
            do {
                try fileManager.removeItem(at: URL(string: url)!)
            } catch let error as NSError {
                print("\(error): \(error.localizedDescription)")
            }
        }
        
        defaults.removeObject(forKey: loginsIdentifier)
        defaults.removeObject(forKey: imagesKeyIdentifier)
    }
    
    private func loadUserLogins() -> [String]? {
        return defaults.array(forKey: loginsIdentifier) as? [String]
    }
    
    private func loadUserImageURLs() -> [String]? {
        return defaults.array(forKey: imagesKeyIdentifier) as? [String]
    }
    
    private func saveImage(_ image: UIImage, with loginName: String) -> URL? {
        if let data = image.jpegData(compressionQuality: 1.0) {
            let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let identifier = UUID()
            let url = documents.appendingPathComponent("\(identifier.uuidString).jpeg")
            
            do {
                try data.write(to: url)
            } catch {
                print("Unable to Write Data to Disk (\(error))")
            }
            return url
        }
        return nil
    }
    
    private func loadImage(from url: URL) -> UIImage? {
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
