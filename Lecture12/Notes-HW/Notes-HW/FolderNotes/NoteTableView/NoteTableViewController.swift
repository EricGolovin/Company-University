//
//  NoteTableViewController.swift
//  Notes-HW
//
//  Created by Eric Golovin on 7/1/20.
//

import UIKit

class NoteTableViewController: UITableViewController {
    
    enum CellIdentifiers: String {
        case cell = "Cell"
        case infoCell = "InformationCell"
    }

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var informationTexView: UITextView!
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
    
    var currentNote: Note?
    var completeAction: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = UIBarButtonItem(systemItem: .cancel, primaryAction: UIAction(title: "Cancel", handler: { _ in 
            self.dismiss(animated: true, completion: nil)
        }), menu: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveNote))
        
        if let date = currentNote?.creationDate, let name = currentNote?.name, let information = currentNote?.information {
            nameTextField.text = name
            dateLabel.text = dateFormatter.string(from: date)
            informationTexView.text = information
        } else {
            dateLabel.text = dateFormatter.string(from: Date())
            currentNote?.creationDate = Date()
        }
        
    }

    
    @objc func saveNote() {
        currentNote?.name = nameTextField.text
        currentNote?.information = informationTexView.text
        completeAction?()
        dismiss(animated: true, completion: nil)
    }
}
