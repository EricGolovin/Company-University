//
//  CreateUserViewController.swift
//  Notes-HW
//
//  Created by Eric Golovin on 7/9/20.
//

import UIKit

class CreateUserViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var chooseImageButton: UIButton!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    // MARK: - Properties
    let credentialManager = UserCredentialsManager()
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Actions

    
    @IBAction func chooseImageTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func textFieldsEditingDidChanged(_ sender: UITextField) {
        if usernameTextField.text != "" && passwordTextField.text != "" {
            signUpButton.isEnabled = true
        }
    }
    
    @IBAction func signUpTapped(_ sender: UIButton) {
        guard let username = usernameTextField.text,
              let password = passwordTextField.text,
              let image = userImageView.image else {
            fatalError("TextFields Text are nil")
        }
        credentialManager.saveNewUser(username: username, password: password, userImage: image)
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
