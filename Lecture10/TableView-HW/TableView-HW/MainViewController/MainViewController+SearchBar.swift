//
//  MainViewController+SearchBar.swift
//  TableView-HW
//
//  Created by Eric Golovin on 6/25/20.
//

import UIKit

extension MainViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        performSearch()
    }
    
    func performSearch() {
        search.performSearch(for: searchBar.text!, completion: { finished in
            self.tableView.reloadData()
            self.view.endEditing(true)
        })
    }
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}
