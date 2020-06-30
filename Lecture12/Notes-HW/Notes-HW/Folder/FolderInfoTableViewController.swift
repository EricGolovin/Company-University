//
//  FolderInfoTableViewController.swift
//  Notes-HW
//
//  Created by Eric Golovin on 6/30/20.
//

import UIKit

class FolderInfoTableViewController: UITableViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var detailsTextView: UITextView!
    @IBOutlet weak var notesCountLabel: UILabel!
    @IBOutlet weak var creationDateLabel: UILabel!
    @IBOutlet weak var modificationDateLabel: UILabel!
    
    // MARK: - Properties
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        return formatter
    }()
    
    var currentFolder: Folder?
    var dismissAction: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Folder Info"
        nameTextField.text = currentFolder?.name ?? "None"
        detailsTextView.text = currentFolder?.information ?? "None"
        notesCountLabel.text = "\(currentFolder?.notes?.count ?? 0)"
        if let creationDate = currentFolder?.creationDate {
            creationDateLabel.text = dateFormatter.string(from: creationDate)
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        dismissAction?()
    }

}
