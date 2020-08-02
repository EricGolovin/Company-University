//
//  AppDelegate.swift
//  Openly
//
//  Created by Eric Golovin on 30.07.2020.
//

import UIKit
import NotificationCenter

private let categoryIdentifier = "AcceptOrReject"

private enum ActionIdentifier: String {
    case accept, reject
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.registerForPushNotifications(application: application)
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    
}

// MARK: - Remote Notifications methods
extension AppDelegate {
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let token = deviceToken.hexEncodedString()
        
        print(token)
        
        registerCustomActions()
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        completionHandler(.newData)
    }

}

// MARK: - User Notification Center Delegate
extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound, .badge])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        defer { completionHandler() }
        
        let identity = response.notification.request.content.categoryIdentifier
        guard identity == categoryIdentifier, let action = ActionIdentifier(rawValue: response.actionIdentifier) else {
            return
        }
        
        switch action {
        case .accept:
            Notification.Name.acceptButton.post()
        case .reject:
            Notification.Name.rejectButton.post()
        }
    }
}


// MARK: - Helper Methods
extension AppDelegate {
    private func registerCustomActions() {
        let accept = UNNotificationAction(identifier: ActionIdentifier.accept.rawValue, title: "Accept")
        
        let reject = UNNotificationAction(identifier: ActionIdentifier.reject.rawValue, title: "Reject")
        
        let category = UNNotificationCategory(identifier: categoryIdentifier, actions: [accept, reject], intentIdentifiers: [])
        
        UNUserNotificationCenter.current().setNotificationCategories([category])
    }
}

extension Data {
    func hexEncodedString() -> String {
        return self.map { String(format: "%02hhx", $0) }.joined()
    }
}
