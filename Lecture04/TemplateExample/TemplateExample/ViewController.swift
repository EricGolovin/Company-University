//
//  ViewController.swift
//  TemplateExample
//
//  Created by Eric Golovin on 29.05.2020.
//  Copyright © 2020 com.ericgolovin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private let testView = TestView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        self.view.addSubview(testView)
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
        setupAutoLayout()
    }
    
    private func setupAutoLayout() {
        testView.translatesAutoresizingMaskIntoConstraints = false
        
        let constraits = [
            testView.widthAnchor.constraint(equalToConstant: 300),
            testView.heightAnchor.constraint(equalToConstant: 300),
            testView.centerXAnchor.constraint(greaterThanOrEqualTo: view.centerXAnchor),
            testView.centerYAnchor.constraint(greaterThanOrEqualTo: view.centerYAnchor),
        ]
        
        NSLayoutConstraint.activate(constraits)
    }
    
    
    // TODO: How to make elements in testView private, however, add tapGesture for textField?
    @objc func hideKeyboard(_ sender: UITapGestureRecognizer) {
        testView.textField.resignFirstResponder()
    }
    
    
}

