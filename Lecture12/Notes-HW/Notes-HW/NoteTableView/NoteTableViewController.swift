//
//  NoteTableViewController.swift
//  Notes-HW
//
//  Created by Eric Golovin on 7/1/20.
//

import UIKit

class NoteTableViewController: UITableViewController {

    // MARK: - Outlets
    @IBOutlet weak var saveBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var informationTexView: UITextView!
    
    // MARK: - Properties
    var currentNote: Note?
    var completeAction: (() -> Void)?
    var interfaceCompletionAction: (() -> Void)?

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        interfaceCompletionAction?()
    }

    // MARK: - Actions
    @IBAction func cancelTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    
    @IBAction func saveTapped(_ sender: UIBarButtonItem) {
        currentNote?.name = nameTextField.text
        currentNote?.information = informationTexView.text
        
        dismiss(animated: true, completion: nil)
        completeAction!()
    }
    
    @IBAction func textFieldEdited(_ sender: UITextField) {
        if !(sender.text == "") {
            saveBarButtonItem.isEnabled = true
        }
    }
}

// MARK: - Helper Methods
extension NoteTableViewController {
    func configureUI() {
        guard let _ = currentNote?.creationDate,
              let stringDate = currentNote?.getStringDate(dateStyle: .medium, timeStyle: .short),
              let name = currentNote?.name,
              let information = currentNote?.information else {
                currentNote?.creationDate = Date()
                dateLabel.text = currentNote?.getStringDate(dateStyle: .medium, timeStyle: .short)
            return
        }
        
        nameTextField.text = name
        dateLabel.text = stringDate
        informationTexView.text = information
    }
}
