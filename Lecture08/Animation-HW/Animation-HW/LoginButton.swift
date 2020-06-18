//
//  Login.swift
//  Animation-HW
//
//  Created by Eric Golovin on 6/19/20.
//  Copyright © 2020 Eric Golovin. All rights reserved.
//

import UIKit

class LoginButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
//    func pulsate() {
//        let pulse = CASpringAnimation(keyPath: "transform.scale")
//        pulse.duration = 1
//        pulse.fromValue = 0.5
//        pulse.toValue = 1.0
//        pulse.autoreverses = true
//        pulse.repeatCount = 1
//        pulse.initialVelocity = 0.5
//        pulse.damping = 1.0
//        layer.add(pulse, forKey: nil)
//    }
}
