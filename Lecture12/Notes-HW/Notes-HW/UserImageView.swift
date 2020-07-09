//
//  UserImageView.swift
//  Notes-HW
//
//  Created by Eric Golovin on 7/9/20.
//

import UIKit

class UserImageView: UIImageView {

    override func awakeFromNib() {
        layer.cornerRadius = bounds.width / 2
    }

}
