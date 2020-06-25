//
//  MainViewController.swift
//  TableView-HW
//
//  Created by Eric Golovin on 6/25/20.
//

import UIKit

class MainViewController: UIViewController {
    enum CellIdentifiers: String {
        case searchResultCell = "SearchResultCell"
    }

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var numberTextField: UITextField!
    
    var search = Search()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cellNib = UINib(nibName: CellIdentifiers.searchResultCell.rawValue, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: CellIdentifiers.searchResultCell.rawValue)
        
        let editButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(commitTableViewEditing(_:)))
        editButtonItem.possibleTitles = ["Edit", "Done"]
        
        navigationItem.leftBarButtonItem = editButtonItem
        searchBar.becomeFirstResponder()
    }
    
    @objc func commitTableViewEditing(_ sender: UIBarButtonItem) {
        if !tableView.isEditing {
            tableView.setEditing(true, animated: true)
            sender.title = "Done"
        } else {
            tableView.setEditing(false, animated: true)
            sender.title = "Edit"
        }
    }
    @IBAction func editingChanged(_ sender: UITextField) {
        search.itemSearchCount = sender.text ?? "10"
    }
    
}
