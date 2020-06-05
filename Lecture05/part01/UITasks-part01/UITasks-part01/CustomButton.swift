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
    
//    override func setNeedsDisplay() {
//        super.setNeedsDisplay()
//        configure()
//    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        applyGradient(colors: [UIColor.blue.cgColor, UIColor.yellow.cgColor])
    }
    
     private func configure() {
//        applyGradient(colors: [UIColor.blue.cgColor, UIColor.yellow.cgColor])
//        self.backgroundColor = UIColor(red: 0, green: 0.2, blue: 0.8, alpha: 0.6)
        configureTitle()
        self.layer.cornerRadius = 5
        print("customButton configured")
    }
    
    private func configureTitle() {
        setTitleColor(.white, for: .normal)
        setTitleColor(.gray, for: .highlighted)
        setTitleColor(.black, for: .disabled)
        
        titleLabel?.layer.shadowColor = UIColor.black.cgColor
        titleLabel?.layer.shadowOffset = CGSize(width: -0.5, height: 0.5)
        titleLabel?.layer.shadowOpacity = 0.5
        titleLabel?.layer.shadowRadius = 2
        titleLabel?.layer.masksToBounds = false
    }
}

extension UIButton {
    func applyGradient(colors: [CGColor]) {
        for layer in layer.sublayers ?? [] {
            if layer.name == "123" {
                layer.removeFromSuperlayer()
                break
            }
        }
        // TODO: Only works when we specify frame in init; Not working in AutoLayout
        let gradientLayer = CAGradientLayer()
        gradientLayer.name = "123"
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [UIColor.yellow.cgColor, UIColor.white.cgColor]
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
