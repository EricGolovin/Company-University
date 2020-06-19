//
//  UserImageView.swift
//  Animation-HW
//
//  Created by Eric Golovin on 6/18/20.
//  Copyright © 2020 Eric Golovin. All rights reserved.
//

import UIKit

class UserImageView: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        layer.cornerRadius = bounds.size.width / 2
        clipsToBounds = true
    }
}
