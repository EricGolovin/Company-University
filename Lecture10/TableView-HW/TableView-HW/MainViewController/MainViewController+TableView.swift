//
//  MainViewController+TableView.swift
//  TableView-HW
//
//  Created by Eric Golovin on 6/25/20.
//

import UIKit

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        search.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.searchResultCell.rawValue, for: indexPath) as! SearchResultCell
        
        cell.configure(for: search.results[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
