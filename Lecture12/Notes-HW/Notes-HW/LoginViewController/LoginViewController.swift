//
//  LoginUserViewController.swift
//  Notes-HW
//
//  Created by Eric Golovin on 7/9/20.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - Identifiers
    private let logInSegueIdentifier = "Login User"

    // MARK: - Outlets
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    // MARK: - Properties
    var userData: UserLoginData?
    private var userCredentialsManager = UserCredentialsManager()
    
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

    @IBAction func loginTapped(_ sender: UIButton) {
        guard let userData = userData else {
            return
        }
        let credentials = Credentials(username: userData.username, password: passwordTextField.text ?? "", profileImage: UIImage())
        userCredentialsManager.loadUser(with: credentials, completion: { correct in
            if correct {
                self.performSegue(withIdentifier: self.logInSegueIdentifier, sender: self)
            } else {
                performWrongPasswordAnimation()
            }
        })
    }
    
}

extension LoginViewController {
    func performWrongPasswordAnimation() {
        UIView.animate(withDuration: 1, animations: {
            self.passwordTextField.backgroundColor = .red
        }, completion: { _ in
            UIView.animate(withDuration: 0.5, animations: {
                self.passwordTextField.backgroundColor = .white
            })
        })
    }
}
