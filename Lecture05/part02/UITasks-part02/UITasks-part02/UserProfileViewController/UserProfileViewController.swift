//
//  UserProfileViewController.swift
//  UITasks-part02
//
//  Created by Eric Golovin on 05.06.2020.
//  Copyright © 2020 com.ericgolovin. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: CustomImageView!
    
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    weak var delegate: RegistrationProtocol?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let userData = PersistencyHelper.loadUserData() {
            profileImageView.image = PersistencyHelper.loadProfileImage()
            
            loginLabel.text = "Login: " + userData.login
            nameLabel.text = "Name: " + userData.name
        }
    }
    

    @IBAction func signOutTapped(_ sender: UIButton) {
        PersistencyHelper.removeData()
        delegate?.viewDidLoad()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
