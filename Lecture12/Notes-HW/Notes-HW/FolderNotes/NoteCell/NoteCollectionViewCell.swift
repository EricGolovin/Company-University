//
//  NoteCollectionViewCell.swift
//  Notes-HW
//
//  Created by Eric Golovin on 6/30/20.
//

import UIKit

class NoteCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var noteImageView: UIImageView!
    @IBOutlet weak var noteTitle: UILabel!
    @IBOutlet weak var noteCreationDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = UIColor(red: 115 / 255, green: 194 / 255, blue: 251 / 255, alpha: 0.2)
        layer.cornerRadius = 10
    }

}
