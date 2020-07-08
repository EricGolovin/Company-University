//
//  UserCollectionViewCell.swift
//  Notes-HW
//
//  Created by Eric Golovin on 7/9/20.
//

import UIKit

class UserCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var userImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let cornerRadius = userImageView.bounds.width / 2
        userImageView.layer.cornerRadius = cornerRadius
        layer.cornerRadius = cornerRadius
    }
}
