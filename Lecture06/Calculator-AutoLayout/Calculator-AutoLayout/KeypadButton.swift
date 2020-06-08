//
//  Keypad.swift
//  Calculator-AutoLayout
//
//  Created by Eric Golovin on 07.06.2020.
//  Copyright © 2020 com.ericgolovin. All rights reserved.
//

import UIKit

@IBDesignable
class KeypadButton: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if bounds.width == bounds.height {
            layer.cornerRadius = bounds.width / 2
        } else {
            layer.cornerRadius = 25
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        updateUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        updateUI()
    }
    
    func updateUI() {
        setTitle("", for: .disabled)
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
