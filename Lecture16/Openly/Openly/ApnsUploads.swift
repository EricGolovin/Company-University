//
//  ApnsUploads.swift
//  Openly
//
//  Created by Eric Golovin on 03.08.2020.
//

import Foundation

import UIKit
import UserNotifications

extension AppDelegate {
    func registerForPushNotifications(application: UIApplication) {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.badge, .sound, .alert]) { [weak center, weak self] granted, _ in
            guard granted, let center = center, let self = self else { return }
            
            center.delegate = self
            
            DispatchQueue.main.async {
                application.registerForRemoteNotifications()
            }
        }
    }
}
