//
//  NavigationViewController.swift
//  TabBar-HW-InCode
//
//  Created by Eric Golovin on 6/17/20.
//  Copyright © 2020 Eric Golovin. All rights reserved.
//

import UIKit

class NavigationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        configureUI()
    }
    
    func configureUI() {
        navigationController?.navigationBar.topItem?.title = "Navigation"
        
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(userDoubleTapped))
        doubleTapGesture.numberOfTapsRequired = 2
        
        let infoLabel = UILabel()
        infoLabel.text = "Double Tap to move to the next Screen"
        infoLabel.sizeToFit()
        infoLabel.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        
        view.addGestureRecognizer(doubleTapGesture)
        view.addSubview(infoLabel)
    }
    
    @objc private func userDoubleTapped() {
        navigationController?.show(SubNavigationViewController(), sender: self)
    }
}
