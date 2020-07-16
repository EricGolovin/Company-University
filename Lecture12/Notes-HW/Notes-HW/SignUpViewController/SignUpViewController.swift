//
//  CreateUserViewController.swift
//  Notes-HW
//
//  Created by Eric Golovin on 7/9/20.
//

import UIKit
import CoreData

class SignUpViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // MARK: - Identifiers
    private let signUpUserSegueIdentifier = "Sign Up User"
    
    // MARK: - Outlets
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var chooseImageButton: UIButton!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    // MARK: - Properties
    private let credentialManager = UserCredentialsManager()
    private let pickerController = UIImagePickerController()
    private let coreDataStack = CoreDataStack.stack
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configurePickerController()
    }
    
    // MARK: - Actions
    @IBAction func chooseImageTapped(_ sender: UIButton) {
        present(pickerController, animated: true)
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
        credentialManager.saveNewUser(username: username, password: password, userImage: image, completion: { saved in
            if saved {
                self.performSegue(withIdentifier: self.signUpUserSegueIdentifier, sender: self)
            } else {
                self.userSignUpErrorAnimation()
            }
        })
    }
}

// MARK: - Image Picker Delegate
extension SignUpViewController {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            return
        }
        userImageView.image = image
        pickerController.dismiss(animated: true)
    }


}

// MARK: - Navigation
extension SignUpViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case signUpUserSegueIdentifier:
            guard let destinationNavigationController = segue.destination as? UINavigationController,
                let foldersVC = destinationNavigationController.viewControllers[0] as? FoldersViewController else {
                return
            }
            foldersVC.currentUser = addNewUser()
        default:
            return
        }
    }

}

// MARK: - Helper Methods
extension SignUpViewController {
    
    func configurePickerController() {
        pickerController.delegate = self
        pickerController.allowsEditing = true
        pickerController.sourceType = .photoLibrary
    }
    
    func userSignUpErrorAnimation() {
        UIView.animate(withDuration: 1, animations: {
            self.usernameTextField.backgroundColor = .red
            self.passwordTextField.backgroundColor = .red
        }, completion: { _ in
            UIView.animate(withDuration: 0.5, animations: {
            self.usernameTextField.backgroundColor = .white
            self.passwordTextField.backgroundColor = .white
            })
        })
    }
    
    func addNewUser() -> User {
        let newUser = User(context: coreDataStack.managedContext)
        newUser.name = usernameTextField.text!
        coreDataStack.saveContext()
        
        return newUser
    }
}
