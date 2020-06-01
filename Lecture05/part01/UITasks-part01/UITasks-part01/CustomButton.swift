//
//  Custom.swift
//  UITasks-part01
//
//  Created by Eric Golovin on 31.05.2020.
//  Copyright © 2020 com.ericgolovin. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    override func setNeedsDisplay() {
        super.setNeedsDisplay()
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
     private func configure() {
//        applyGradient(colors: [UIColor.blue.cgColor, UIColor.yellow.cgColor])
        self.backgroundColor = .blue
        configureTitle()
        self.layer.cornerRadius = 5
        print("customButton configured")
    }
    
    private func configureTitle() {
        setTitleColor(.white, for: .normal)
        setTitleColor(.gray, for: .highlighted)
        
        titleLabel?.layer.shadowColor = UIColor.black.cgColor
        titleLabel?.layer.shadowOffset = CGSize(width: -0.5, height: 0.5)
        titleLabel?.layer.shadowOpacity = 0.5
        titleLabel?.layer.shadowRadius = 2
        titleLabel?.layer.masksToBounds = false
    }
}

extension UIButton {
    func applyGradient(colors: [CGColor]) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [UIColor.yellow.cgColor, UIColor.white.cgColor]
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
