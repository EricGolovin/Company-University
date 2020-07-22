//
//  DatePickerTableViewCell.swift
//  AlarmApp
//
//  Created by Eric Golovin on 23.07.2020.
//

import UIKit

class DatePickerTableViewCell: UITableViewCell {

    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        datePicker.minimumDate = Date()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func selectedDate() -> Date {
        return datePicker.date
    }
    
}
