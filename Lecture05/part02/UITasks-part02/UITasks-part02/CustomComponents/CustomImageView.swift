//
//  CustomImageView.swift
//  UITasks-part01
//
//  Created by Eric Golovin on 01.06.2020.
//  Copyright © 2020 com.ericgolovin. All rights reserved.
//

import UIKit

//@IBDesignable
class CustomImageView: UIImageView {

    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    override init(image: UIImage?) {
        super.init(image: image)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configure()
    }
    
    private func configure() {
        self.layer.masksToBounds = true
        
        // TODO: How to make flexible to all sizes (this one only work with size 300 by 300)
        self.layer.cornerRadius = bounds.width / 2
        
        self.layer.borderColor = UIColor.purple.cgColor
        
    }

}
