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
    
    var search = Search()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cellNib = UINib(nibName: CellIdentifiers.searchResultCell.rawValue, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: CellIdentifiers.searchResultCell.rawValue)
        
    }

}
