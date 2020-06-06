//
//  ViewController.swift
//  UITasks-part02
//
//  Created by Eric Golovin on 05.06.2020.
//  Copyright © 2020 com.ericgolovin. All rights reserved.
//

import UIKit

@objc protocol RegistrationProtocol where Self: UIViewController {
    @objc func presentViewController(_ contoller: UIViewController)
}

class MainViewController: UIViewController, RegistrationProtocol {
    
    struct Storyboard {
        enum IDs: String {
            case anonymus = "AnonymusUserViewController"
            case register = "RegisterViewController"
            case profile = "UserProfileViewContoller"
        }
        enum Names: String {
            case anonymus = "Anonymus"
            case register = "Register"
            case profile = "Profile"
        }
    }
    
    var registerViewController = RegisterViewController()
    var userProfileViewController = UserProfileViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let _ = PersistencyHelper.loadUserData() else {
            let anonymusUserViewController = UIStoryboard(name: Storyboard.Names.anonymus.rawValue, bundle: .main).instantiateViewController(identifier: Storyboard.IDs.anonymus.rawValue) as AnonymusUserViewController
            anonymusUserViewController.delegate = self
            
            let regiterViewController = UIStoryboard(name: Storyboard.Names.register.rawValue, bundle: .main).instantiateViewController(identifier: Storyboard.IDs.register.rawValue) as RegisterViewController
            regiterViewController.delegate = self
            
            addChild(anonymusUserViewController)
            addChild(regiterViewController)
            
            DispatchQueue.main.async {
                self.presentViewController(self.children.first!)
            }
            
            let userProfileViewContoller = UIStoryboard(name: Storyboard.Names.profile.rawValue, bundle: .main).instantiateViewController(identifier: Storyboard.IDs.profile.rawValue) as UserProfileViewController
            userProfileViewContoller.delegate = self
            addChild(userProfileViewContoller)
            
            return
        }
        
        let userProfileViewContoller = UIStoryboard(name: Storyboard.Names.profile.rawValue, bundle: .main).instantiateViewController(identifier: Storyboard.IDs.profile.rawValue) as UserProfileViewController
        userProfileViewContoller.delegate = self
        addChild(userProfileViewContoller)
        
        DispatchQueue.main.async {
            self.presentViewController(self.children.first!)
        }
    }
    
    @objc func presentViewController(_ contoller: UIViewController) {
        contoller.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(contoller, animated: false)
    }

}



