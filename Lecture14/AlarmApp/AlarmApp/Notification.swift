//
//  Notification.swift
//  AlarmApp
//
//  Created by Eric Golovin on 27.07.2020.
//

import Foundation
import NotificationCenter

class Notification: NSObject, UNUserNotificationCenterDelegate {
    
    static let current = Notification()
    
    private var requestIdentifiers = [String]()
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    private override init() { super.init() }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        switch response.actionIdentifier {
        case UNNotificationDismissActionIdentifier:
            print("Dismiss Action")
        case UNNotificationDefaultActionIdentifier:
            print("Default")
        case "Snooze":
            print("Snooze")
            registerNotification(title: response.notification.request.content.title, date: Date(timeIntervalSinceNow: 300))
        case "Delete":
            print("Delete")
        default:
            print("Unknown action")
        }
        
        completionHandler()
    }
    
    func registerNotification(title: String, date: Date) {
        let uuidString = UUID().uuidString
        requestIdentifiers.append(uuidString)
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = "Alarm at \(date.getAlarmCellString())"
        content.sound = .defaultCriticalSound(withAudioVolume: 1)
        content.categoryIdentifier = uuidString
        
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current
        
        dateComponents.weekday = Calendar.current.component(.weekday, from: date)
        dateComponents.hour = Calendar.current.component(.hour, from: date)
        dateComponents.minute = Calendar.current.component(.minute, from: date)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { (error) in
            if error != nil {
            }
        }
        let snoozeAction = UNNotificationAction(identifier: "Snooze", title: "Snooze", options: [])
        let deleteAction = UNNotificationAction(identifier: "Delete", title: "Delete", options: [.destructive])
        let category = UNNotificationCategory(identifier: uuidString, actions: [snoozeAction, deleteAction], intentIdentifiers: [], options: [])
        
        notificationCenter.setNotificationCategories([category])
    }
    
    func removeAllNotificationRequests() {
        notificationCenter.removePendingNotificationRequests(withIdentifiers: requestIdentifiers)
    }
}
