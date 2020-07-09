//
//  LoginUserViewController.swift
//  Notes-HW
//
//  Created by Eric Golovin on 7/9/20.
//

import UIKit

class LoginUserViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    // MARK: - Properties
    var userData: UserLoginData?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureUI()
    }
    
    private func configureUI() {
        guard let user = userData else {
            return
        }
        userImageView.image = user.image
        usernameLabel.text = user.username
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
