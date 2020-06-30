//
//  FolderTableViewCell.swift
//  Notes-HW
//
//  Created by Eric Golovin on 6/30/20.
//

import UIKit

class FolderTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var folderImageView: UIImageView!
    @IBOutlet weak var folderTitleLabel: UILabel!
    @IBOutlet weak var folderCreationLabel: UILabel!
    
    // MARK: - Properties
    var infoAction: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        folderImageView.image = UIImage(systemName: "folder.badge.questionmark")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Actions
    
    @IBAction private func infoButtonTapped(_ sender: UIButton) {
        infoAction?()
    }
    
}
