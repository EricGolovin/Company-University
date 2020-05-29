// 
//  TestView.swift
//  TemplateExample
//
//  Created by Eric Golovin on 29.05.2020.
//  Copyright © 2020 com.ericgolovin. All rights reserved.
//

import UIKit

class TestView: UIView {
    
    lazy var label: UILabel = {
        var label = UILabel()
        label.text = "TestView"
        return label
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Second view component"
        
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.systemGray.cgColor
        
        return textField
    }()
    
    lazy var button: UIButton = {
        var button = UIButton()
        button.setTitle("Action button", for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var stackView: UIStackView = {
        var stackView = UIStackView()
        stackView.addArrangedSubview(self.label)
        stackView.addArrangedSubview(self.textField)
        stackView.addArrangedSubview(self.button)
        
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    private func setupView() {
        self.addSubview(stackView)
        setupAutoLayout()
    }
    
    private func setupAutoLayout() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        let constraits = [
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.rightAnchor.constraint(equalTo: self.rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: self.leftAnchor)
        ]
        
        NSLayoutConstraint.activate(constraits)
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        print("Action Button was tapped")
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
