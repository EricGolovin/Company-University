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
    @IBOutlet weak var saveBarButtonItem: UIBarButtonItem!
    
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
    var saveAction: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        saveBarButtonItem.isEnabled = true
    }
    
    @IBAction func cancelTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    @IBAction func saveTapped(_ sender: UIBarButtonItem) {
        currentFolder?.name = nameTextField.text
        currentFolder?.information = detailsTextView.text
        saveAction?()
        dismiss(animated: true)
    }
}
