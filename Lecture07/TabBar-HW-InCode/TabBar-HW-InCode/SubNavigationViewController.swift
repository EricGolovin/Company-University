//
//  SubNavigationViewController.swift
//  TabBar-HW-InCode
//
//  Created by Eric Golovin on 6/17/20.
//  Copyright © 2020 Eric Golovin. All rights reserved.
//

import UIKit

class SubNavigationViewController: UIViewController {
    
    private let navToResetButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        configureUI()
    }
    
    func configureUI() {
        
        navToResetButton.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        navToResetButton.setTitle("Move to Reset", for: .normal)
        navToResetButton.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        navToResetButton.layer.cornerRadius = 10
        navToResetButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        navToResetButton.sizeToFit()
        navToResetButton.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        
        view.addSubview(navToResetButton)
    }
    
    @objc  func buttonPressed(_ sender: UIButton) {
        tabBarController?.selectedViewController = tabBarController?.viewControllers?.last
        navigationController?.popToRootViewController(animated: false)
    }

}
