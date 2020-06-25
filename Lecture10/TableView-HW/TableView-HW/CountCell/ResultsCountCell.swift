//
//  CountCell.swift
//  TableView-HW
//
//  Created by Eric Golovin on 6/25/20.
//

import UIKit

class ResultsCountCell: UITableViewCell {
    
    @IBOutlet weak var countLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    // MARK: - Public Methods
    func configure(for counter: Int) {
        countLabel.text = "Results: \(counter)"
    }
    
}
