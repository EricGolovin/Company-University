//
//  SceneDelegate.swift
//  TabBar-HW-InCode
//
//  Created by Eric Golovin on 6/17/20.
//  Copyright © 2020 Eric Golovin. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let mainViewController = MainViewController() as UIViewController
        let resetViewController = ResetViewController() as UIViewController
        
        let tabBarController = UITabBarController()
        let navVCNavigationController = UINavigationController(rootViewController: FirstNavigationViewController())
        
        let mainTabBarItem = UITabBarItem(title: "Image", image: UIImage(systemName: "smiley"), selectedImage: UIImage(systemName: "smiley.fill"))
        let navigationTabBarItem = UITabBarItem(title: "Navigation", image: UIImage(systemName: "square.grid.3x2"), selectedImage: UIImage(systemName: "square.grid.3x2.fill"))
        let resetTabBarItem = UITabBarItem(title: "Reset", image: UIImage(systemName: "xmark.square"), selectedImage: UIImage(systemName: "xmark.square.fill"))
        
        mainViewController.tabBarItem = mainTabBarItem
        navVCNavigationController.tabBarItem = navigationTabBarItem
        resetViewController.tabBarItem = resetTabBarItem
        
        tabBarController.viewControllers = [mainViewController, navVCNavigationController, resetViewController]
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        window?.windowScene = windowScene
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

