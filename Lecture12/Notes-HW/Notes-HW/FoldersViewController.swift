//
//  FoldersViewController.swift
//  Notes-HW
//
//  Created by Eric Golovin on 6/30/20.
//

import UIKit
import CoreData

class FoldersViewController: UIViewController {
    
    enum CellIdentifiers: String {
        case cell = "Cell"
    }
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    var currentUser: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TableView Configuration
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: CellIdentifiers.cell.rawValue)
        
        // Setting Up CoreData Stack
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let userName = "TestUserName"
        let request: NSFetchRequest<User> = User.fetchRequest()
        
        do {
            let results = try managedContext.fetch(request)
            
            if results.count > 0 {
                currentUser = results.first
            } else {
                currentUser = User(context: managedContext)
                currentUser?.name = userName
                try managedContext.save()
            }
            
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        navigationItem.title = currentUser?.name ?? "Failed to Load Name"
    }
    
    // MARK: - Actions
    
    @IBAction func addFolder(_ sender: UIBarButtonItem) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let newFolder = Folder(context: managedContext)
        
        let alert = UIAlertController(title: "Add Folder", message: "Type Folder Info", preferredStyle: .alert)
        alert.addTextField(configurationHandler: { textField in
        })
        
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: { _ in
            newFolder.name = alert.textFields?.first?.text
            self.currentUser?.addToFolders(newFolder)
            self.tableView.reloadData()
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
}

extension FoldersViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        currentUser?.folders?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.cell.rawValue, for: indexPath)
        
        guard let folder = currentUser?.folders?[indexPath.row] as? Folder, let folderName = folder.name else {
            return cell
        }
        
        cell.textLabel?.text = folderName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        switch editingStyle {
        case .delete:
            guard let folderToRemove = currentUser?.folders?[indexPath.row] as? Folder else {
                return
            }
            
            currentUser?.removeFromFolders(folderToRemove)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Could not fetch \(error), \(error.userInfo)")
            }
            tableView.reloadData()
        case .none:
            break
        case .insert:
            break
        @unknown default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate, let selectedFolder = currentUser?.folders?[indexPath.row] as? Folder else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let folderDetailsTableViewController = UIStoryboard(name: "FolderInfo", bundle: nil).instantiateViewController(identifier: "FolderInfo") as FolderInfoTableViewController
        folderDetailsTableViewController.currentFolder = selectedFolder
        folderDetailsTableViewController.dismissAction = {
            // TODO: Update Folder in CoreData Stack
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Could not fetch \(error), \(error.userInfo)")
            }
            self.tableView.reloadData()
        }
       present(folderDetailsTableViewController, animated: true, completion: nil)
    }
}
