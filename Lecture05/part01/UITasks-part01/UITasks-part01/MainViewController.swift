//
//  ViewController.swift
//  UITasks-part01
//
//  Created by Eric Golovin on 31.05.2020.
//  Copyright © 2020 com.ericgolovin. All rights reserved.
//

import UIKit

protocol RegistrationProtocol: class {
    var anonymusUserViewController: AnonymusUserViewController { get set}
    var registerViewController: RegisterViewController { get set }
}

class MainViewController: UIViewController, RegistrationProtocol {
    
    var anonymusUserViewController = AnonymusUserViewController()
    var registerViewController = RegisterViewController()
    
    private lazy var button: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        button.center = view.center
        button.backgroundColor = UIColor(red: 0, green: 0, blue: 1, alpha: 0.4)
        button.setTitle("Start", for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 25)
        button.layer.cornerRadius = 10
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        
        updateUI()
    }
    
    private func updateUI() {
        view.addSubview(button)
        self.view.backgroundColor = .white
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        anonymusUserViewController.modalPresentationStyle = .fullScreen
        anonymusUserViewController.delegate = self
        present(anonymusUserViewController, animated: true, completion: nil)
    }


}

