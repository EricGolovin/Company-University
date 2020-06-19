//
//  ViewController.swift
//  Animation-HW
//
//  Created by Eric Golovin on 6/18/20.
//  Copyright © 2020 Eric Golovin. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    enum ArrowType {
        case left
        case right
    }
    
    @IBOutlet private weak var userImageView: UserImageView!
    
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var nextButton: UIButton!
    
    @IBOutlet private weak var imageName: UILabel!
    @IBOutlet private weak var loginTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var loginButton: LoginButton!
    
    var startImageNameCenter: CGPoint!
    var startLoginCenter: CGPoint!
    var startPasswordCenter: CGPoint!
    var startLoginButtonCenter: CGPoint!

    private let userProfile = UserProfile()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userProfile.loadNextImage(to: userImageView, with: imageName)
        
        let buttonConfig = UIImage.SymbolConfiguration(pointSize: 25, weight: .regular, scale: .large)
        
        backButton.setImage(UIImage(systemName: "arrow.left.circle", withConfiguration: buttonConfig)!, for: .normal)
        backButton.isEnabled = false
        
        nextButton.setImage(UIImage(systemName: "arrow.right.circle", withConfiguration: buttonConfig)!, for: .normal)
        
        startImageNameCenter = imageName.center
        startLoginCenter = loginTextField.center
        startPasswordCenter = passwordTextField.center
        startLoginButtonCenter = loginButton.center
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0, animations: {
            self.loginTextField.center.x -= self.view.bounds.width
            self.passwordTextField.center.x -= self.view.bounds.width
            self.loginButton.center.x -= self.view.bounds.width
        })
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 1, delay: 0.0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.2, options: [], animations: {
            self.loginTextField.center.x += self.view.bounds.width
        }, completion: nil)
        UIView.animate(withDuration: 1, delay: 0.5, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.2, options: [], animations: {
            self.passwordTextField.center.x += self.view.bounds.width
        }, completion: nil)
        UIView.animate(withDuration: 1, delay: 1, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.2, options: [], animations: {
            self.loginButton.center.x += self.view.bounds.width
        }, completion: nil)
    }
    
    @IBAction func loginTapped(_ sender: LoginButton) {
        if loginTextField.text == imageName.text || passwordTextField.text == "0" {
            view.endEditing(true)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                self.animateLogin(successfully: true)
            })
        } else {
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)
            UIView.animate(withDuration: 2, delay: 0.0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.2, options: [.curveEaseInOut], animations: {
                self.loginButton.backgroundColor = .red
                self.loginButton.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                self.loginTextField.center.x += self.view.bounds.width
                self.passwordTextField.center.x -= self.view.bounds.width
                self.loginTextField.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                self.passwordTextField.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            }, completion: { _ in
                UIView.animate(withDuration: 1, delay: 0.0, options: [.curveEaseInOut], animations: {
                    self.loginButton.backgroundColor = .white
                    self.loginButton.transform = .identity
                    self.loginTextField.transform = .identity
                    self.passwordTextField.transform = .identity
                    self.loginTextField.center = self.startLoginCenter
                    self.passwordTextField.center = self.startPasswordCenter
                })
            })
//            sender.pulsate()
        }
    }
    
    @IBAction private func backTapped(_ sender: UIButton) {
        userProfile.getPreviousImage(to: userImageView, with: imageName) ? sender.isEnabled(true) : sender.isEnabled(false)
        animateButton(sender, arrowType: .left)
    }
    
    @IBAction private func nextTapped(_ sender: UIButton) {
        backButton.isEnabled = true
        userProfile.loadNextImage(to: userImageView, with: imageName)
        animateButton(sender, arrowType: .right)
    }


    func animateButton(_ button: UIButton, arrowType: ArrowType) {
        let initialTintColor = button.tintColor
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.warning)
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.5, options: [.curveEaseInOut], animations: {
            button.transform = CGAffineTransform(scaleX: 2, y: 2)
            button.tintColor = .red
        }, completion: nil)
        UIView.animate(withDuration: 0.5, delay: 0.1, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.5, options: [.curveEaseInOut], animations: {
            button.transform = CGAffineTransform(scaleX: 1, y: 1)
            button.tintColor = initialTintColor
        }, completion: nil)
    }
    
    func animateLogin(successfully: Bool) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        UIView.transition(with: loginTextField, duration: 0.5, options: [], animations: {
            self.loginTextField.center.y += self.view.bounds.width
            self.loginTextField.alpha = 0.0
        })
        UIView.transition(with: passwordTextField, duration: 0.5, options: [], animations: {
            self.passwordTextField.center.y += self.view.bounds.width
            self.passwordTextField.alpha = 0.0
        })
        UIView.transition(with: loginButton, duration: 0.5, options: [], animations: {
            self.loginButton.center.y += self.view.bounds.width
            self.loginButton.alpha = 0.0
        })
        UIView.transition(with: imageName, duration: 1, options: [], animations: {
            self.imageName.center = self.startLoginCenter
            self.imageName.transform = CGAffineTransform(scaleX: 2.5, y: 2.5)
            successfully ? self.imageName.setTextColor(.green) : self.imageName.setTextColor(.red)
        })
        UIView.transition(with: imageName, duration: 1, options: [], animations: {
            self.imageName.center = self.startLoginCenter
            self.imageName.transform = CGAffineTransform(scaleX: 2.5, y: 2.5)
            successfully ? self.imageName.setTextColor(.green) : self.imageName.setTextColor(.red)
        })
        
        
        UIView.transition(with: imageName, duration: 1, options: [], animations: {
            self.imageName.center = self.startLoginCenter
            self.imageName.transform = CGAffineTransform(scaleX: 2.5, y: 2.5)
            successfully ? self.imageName.setTextColor(.green) : self.imageName.setTextColor(.red)
        }, completion: nil)
        
        UIView.animate(withDuration: 1, delay: 2, options: [.curveEaseInOut], animations: {
            self.imageName.center = self.startImageNameCenter
            self.imageName.transform = CGAffineTransform(scaleX: 1, y: 1)
        }, completion: { _ in
            self.imageName.textColor = .white
            UIView.animate(withDuration: 1, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.5, options: [], animations: {
                self.loginTextField.center = self.startLoginCenter
                self.loginTextField.alpha = 1.0
            })
            UIView.animate(withDuration: 1, delay: 0.5, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.4, options: [], animations: {
                self.passwordTextField.center = self.startPasswordCenter
                self.passwordTextField.alpha = 1.0
            })
            UIView.animate(withDuration: 1, delay: 1, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.3, options: [], animations: {
                self.loginButton.center = self.startLoginButtonCenter
                self.loginButton.alpha = 1.0
                self.loginTextField.text = ""
                self.passwordTextField.text = ""
            })
        })
    }
}

extension UIButton {
    func isEnabled(_ state: Bool) {
        isEnabled = state
    }
}

extension UILabel {
    func setTextColor(_ color: UIColor) {
        textColor = color
    }
}

//
