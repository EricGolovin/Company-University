//
//  FolderInfoTableViewController.swift
//  Notes-HW
//
//  Created by Eric Golovin on 6/30/20.
//

import UIKit

class FolderInfoTableViewController: UITableViewController {
    
    enum CellIdentifiers: String {
        case modificationCell = "LastModificationCell"
    }
    
    // MARK: - Outlets
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var detailsTextView: UITextView!
    @IBOutlet private weak var notesCountLabel: UILabel!
    @IBOutlet private weak var creationDateLabel: UILabel!
    @IBOutlet private weak var modificationDateLabel: UILabel!
    
    // MARK: - Properties
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        return formatter
    }()
    
    var currentFolder: Folder?
    var dismissAction: (() -> Void)?
    private var currentFolderEdited = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(systemItem: .cancel, primaryAction: UIAction(title: "Cancel", handler: { _ in
            self.dismiss(animated: true, completion: nil)
        }))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .save, primaryAction: UIAction(title: "Save", handler: { _ in
            if self.currentFolderEdited || self.detailsTextView.text != self.currentFolder?.information {
                self.currentFolder?.name = self.nameTextField.text
                self.currentFolder?.information = self.detailsTextView.text
                self.currentFolder?.modificationDate = Date()
                self.dismissAction?()
            }
            self.dismiss(animated: true, completion: nil)
        }))
        
        navigationItem.title = "Folder Info"
        
        nameTextField.text = currentFolder?.name ?? "None"
        detailsTextView.text = currentFolder?.information ?? "None"
        notesCountLabel.text = "\(currentFolder?.notes?.count ?? 0)"
        
        if let creationDate = currentFolder?.creationDate {
            creationDateLabel.text = dateFormatter.string(from: creationDate)
        }
        
        if let modificationDate = currentFolder?.modificationDate {
            modificationDateLabel.text = dateFormatter.string(from: modificationDate)
        } else {
            modificationDateLabel.text = "None"
        }
        
    }
    
    @IBAction func textFieldEdited(_ sender: UITextField) {
        currentFolderEdited = true
    }
}
