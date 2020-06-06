//
//  Custom.swift
//  UITasks-part01
//
//  Created by Eric Golovin on 31.05.2020.
//  Copyright © 2020 com.ericgolovin. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        configure()
//    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    override func layoutSubviews() {
        // TODO: Fix every call of this func when tapping button
        super.layoutSubviews()
        configure()
    }
    
    private func configure() {
        applyGradient(colors: [UIColor.blue.cgColor, UIColor.yellow.cgColor], radius: cornerRadius)
        setTitleColor(.white, for: .normal)
        setTitleColor(.gray, for: .disabled)
        print("customButton configured")
    }
}

extension UIButton {
    func applyGradient(colors: [CGColor], radius: CGFloat) {
        for layer in layer.sublayers ?? [] {
            if layer.name == "gradient" {
                layer.removeFromSuperlayer()
                break
            }
        }
        let gradientLayer = CAGradientLayer()
        gradientLayer.name = "gradient"
        gradientLayer.frame = self.bounds
        gradientLayer.colors = colors
        gradientLayer.cornerRadius = radius
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
