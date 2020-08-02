//
//  NotificationService.swift
//  NotificationService
//
//  Created by Eric Golovin on 30.07.2020.
//

import UserNotifications
import UIKit

class NotificationService: UNNotificationServiceExtension {
    
    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?
    
    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
        
        if let bestAttemptContent = bestAttemptContent {
            // Modify the notification content here...
//            print(bestAttemptContent)
            bestAttemptContent.title = "Hello, my Master Coder"
            bestAttemptContent.body = "..."
            
            guard let apnsData = bestAttemptContent.userInfo["data"] as? [String: Any],
                  let imageStringURL = apnsData["image-url"] as? String,
                  let imageURL = URL(string: imageStringURL) else {
                contentHandler(request.content)
                return
            }
            print(imageURL)
            
            
            downloadImageFrom(url: imageURL, with: { attachment in
                if let attachment = attachment {
                    bestAttemptContent.attachments = [attachment]
                }
                contentHandler(bestAttemptContent)
            })
            
        }
    }
    
    override func serviceExtensionTimeWillExpire() {
        // Called just before the extension will be terminated by the system.
        // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
        if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
            contentHandler(bestAttemptContent)
        }
    }
    
}

extension NotificationService {
    private func downloadImageFrom(url: URL, with completionHandler: @escaping (UNNotificationAttachment?) -> Void) {
        let task = URLSession.shared.downloadTask(with: url) { [weak self] url, response, error in
            guard let url = url else {
                completionHandler(nil)
                return
            }
            
            var urlPath = URL(fileURLWithPath: NSTemporaryDirectory())

            let uniqueURLEnding = ProcessInfo.processInfo.globallyUniqueString + ".png"
            urlPath = urlPath.appendingPathComponent(uniqueURLEnding)
            
            self!.saveToShared(with: url)
            try? FileManager.default.moveItem(at: url, to: urlPath)
            
            self!.saveToShared(with: urlPath)
            
            do {
                let attachment = try UNNotificationAttachment(identifier: "picture", url: urlPath, options: nil)
                completionHandler(attachment)
            } catch {
                completionHandler(nil)
            }
        }
        task.resume()
    }
    
    func saveToShared(with url: URL) {
        guard let defaults = UserDefaults(suiteName: "group.com.ericgolovin.Openly.demodata"),
            let fileManagerDefautlsURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.ericgolovin.Openly.demodata") else {
            fatalError("Error: Cannot get url to group")
        }
        
        if let oldURL = defaults.url(forKey: "notificationImage") {
            do {
                try FileManager.default.removeItem(at: oldURL)
            } catch {
                print("\(error): \(error.localizedDescription)")
            }
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Error: Cannot get data form url")
        }
            
        let uniqueURLEnding = ProcessInfo.processInfo.globallyUniqueString + ".png"
        let urlPath = fileManagerDefautlsURL.appendingPathComponent(uniqueURLEnding)
        
        do {
            try data.write(to: urlPath)
        } catch {
            print("\(error): \(error.localizedDescription)")
        }
        
        defaults.set(urlPath, forKey: "notificationImage")
    }
}

// MARK: APS Request example
/*
 
 {"aps":{"alert":"Testing.. (3)","badge":1,"sound":"default", "category": "AcceptOrReject", "mutable-content": 1}, "data":{"image-url":"https://www.hello.com/img_/hellowithwaves.png"}}
 
  {"aps":{"alert":"Testing.. (24)","badge":1,"sound":"default", "category": "AcceptOrReject", "mutable-content": 1}, "data":{"image-url":"https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcR3J6MdUgndGDw6uwiTgC1OCFWgmLQOxWJQaKjxVQkHiaHE_kx7W5rtBkOF4SSjzZYZTbut_bFy_fNyJLVuxEFq5bv_M3Z_x2jw4g-1&usqp=CAU&ec=45687382.png"}}
*/
