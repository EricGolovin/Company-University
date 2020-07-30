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
            print(bestAttemptContent)
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
        let task = URLSession.shared.downloadTask(with: url) { url, response, error in
            guard let url = url else {
                completionHandler(nil)
                return
            }
            
            var urlPath = URL(fileURLWithPath: NSTemporaryDirectory())

            let uniqueURLEnding = ProcessInfo.processInfo.globallyUniqueString + ".jpg"
            urlPath = urlPath.appendingPathComponent(uniqueURLEnding)
            
            try? FileManager.default.moveItem(at: url, to: urlPath)
            
            do {
                let attachment = try UNNotificationAttachment(identifier: "picture", url: url, options: nil)
                completionHandler(attachment)
            } catch {
                completionHandler(nil)
            }
        }
        task.resume()
    }
}
