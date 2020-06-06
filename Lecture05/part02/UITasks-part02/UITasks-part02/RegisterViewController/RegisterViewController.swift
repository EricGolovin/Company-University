//
//  RegisterViewControllerViewController.swift
//  UITasks-part02
//
//  Created by Eric Golovin on 05.06.2020.
//  Copyright © 2020 com.ericgolovin. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var registerButton: CustomButton!
    
    
    weak var delegate: RegistrationProtocol?
    var passwordChecker = PasswordChecker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordTextField.addTarget(self, action: #selector(textFieldEdited(_:)), for: .editingDidEnd)
        
        registerButton.isEnabled = false
    }
    
    @IBAction func chooseProfileTapped(_ sender: UIButton) {
        pickPhoto()
    }
    
    @IBAction func registerTapped(_ sender: CustomButton) {
        PersistencyHelper.saveUserData(UserData(login: loginTextField.text ?? "None", name: nameTextField.text ?? "None", imagePath: "None"))
        PersistencyHelper.saveUserImage(profileImageView.image!)
        removeFromParent()
        if let destinationVC = delegate?.children.first! as? UserProfileViewController {
            delegate?.presentViewController(destinationVC)
        }
        
    }
    
    @IBAction func userTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @objc func textFieldEdited(_ sender: UITextField) {
        if let password = passwordTextField.text, let login = loginTextField.text, let name = nameTextField.text {
            if login != "" && name != "" {
                passwordChecker.check(password: password) ? registerButton.setEnabled(to: true) : registerButton.setEnabled(to: false)
            }
        }
    }

}

extension UIButton {
    func setEnabled(to state: Bool) {
        isEnabled = state
    }
}
