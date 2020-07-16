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
        
        let cornerRadius = self.bounds.width / 2
        userImageView.layer.cornerRadius = cornerRadius
        layer.cornerRadius = cornerRadius
        
        clipsToBounds = false
        layer.shadowColor = UIColor.white.cgColor
        layer.shadowRadius = 20
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 5, height: 5)
    }
}
