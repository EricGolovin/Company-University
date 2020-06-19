//
//  ResetViewController.swift
//  TabBar-HW-InCode
//
//  Created by Eric Golovin on 6/17/20.
//  Copyright © 2020 Eric Golovin. All rights reserved.
//

import UIKit

class ResetViewController: UIViewController {
    
    private let showNavButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        configureUI()
    }
    
    private func configureUI() {
        
        showNavButton.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        showNavButton.setTitle("How Navigation Controller", for: .normal)
        showNavButton.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        showNavButton.layer.cornerRadius = 10
        showNavButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        showNavButton.sizeToFit()
        showNavButton.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        
        view.addSubview(showNavButton)
    }
    
    @objc private func buttonPressed(_ sender: UIButton) {
        let navVCs = UINavigationController(rootViewController: FirstNavigationViewController())
        let barItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(barButtonItemTapped))
        
        navVCs.navigationBar.topItem?.rightBarButtonItem = barItem
        present(navVCs, animated: true, completion: nil)
    }
    
    @objc private func barButtonItemTapped() {
        dismiss(animated: true, completion: nil)
    }

}
