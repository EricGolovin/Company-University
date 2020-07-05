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
    @IBOutlet weak var sortBarButton: UIBarButtonItem!
    
    // MARK: - Properties
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
    
    var currentUser: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TableView Configuration
        configureTableView()
        
        // Setting Up CoreData Stack
        
        // TODO: - To Model File
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
        
        navigationController?.isToolbarHidden = true
    }
    
    
    func configureTableView() {
        tableView.register(UINib(nibName: "FolderTableViewCell", bundle: nil), forCellReuseIdentifier: CellIdentifiers.cell.rawValue)
    }
    // MARK: - Actions
    
    @IBAction func sortTapped(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Sort Folders", message: "Choose sort option", preferredStyle: .actionSheet)
        
        let byNameAction = UIAlertAction(title: "by Name", style: .default, handler: { _ in
            guard let currentUserFolders = self.currentUser?.folders,
                  let sortedUserFolders = currentUserFolders.sorted(by: {
                    ($0 as! Folder).name ?? "" < ($1 as! Folder).name ?? ""
                  }) as? [Folder] else {
                        fatalError("Error: Cannot sort user folders")
                    }
            self.currentUser?.folders = NSOrderedSet(array: sortedUserFolders)
            self.tableView.reloadData()
        })
        
        let byDateAction = UIAlertAction(title: "by Date", style: .default, handler: { _ in
            guard let currentUserFolders = self.currentUser?.folders,
                  let sortedUserFolders = currentUserFolders.sorted(by: {
                    ($0 as! Folder).creationDate ?? Date() < ($1 as! Folder).creationDate ?? Date()
                  }) as? [Folder] else {
                        fatalError("Error: Cannot sort user folders")
                    }
            self.currentUser?.folders = NSOrderedSet(array: sortedUserFolders)
            self.tableView.reloadData()
        })
        
        alert.addAction(byNameAction)
        alert.addAction(byDateAction)
        present(alert, animated: true, completion: nil)
    }
    @IBAction func addFolder(_ sender: UIBarButtonItem) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let newFolder = Folder(context: managedContext)
        
        
        let alert = UIAlertController(title: "Add Folder", message: "Type Folder Information", preferredStyle: .alert)
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Enter Title"
        })
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Enter Details"
        })
        
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: { _ in
            newFolder.name = alert.textFields?.first?.text
            newFolder.information = alert.textFields?.last?.text
            newFolder.creationDate = Date()
            
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
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.cell.rawValue, for: indexPath) as! FolderTableViewCell
        
        guard let folder = currentUser?.folders?[indexPath.row] as? Folder,
              let folderName = folder.name,
              let folderCreationDate = folder.creationDate else {
            return cell
        }
        
        cell.folderTitleLabel.text = folderName
        cell.folderCreationLabel.text = dateFormatter.string(from: folderCreationDate)
        
        cell.infoAction = { [weak self] in
            // TODO: To Method
            // TODO: Give Folder
            self?.tableView.deselectRow(at: indexPath, animated: true)
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate, let selectedFolder = self?.currentUser?.folders?[indexPath.row] as? Folder else {
                return
            }
            let managedContext = appDelegate.persistentContainer.viewContext
            
            let folderDetailsTableViewController = UIStoryboard(name: "FolderInfo", bundle: nil).instantiateViewController(identifier: "FolderInfo") as FolderInfoTableViewController
            folderDetailsTableViewController.currentFolder = selectedFolder
            folderDetailsTableViewController.dismissAction = {
                do {
                    try managedContext.save()
                } catch let error as NSError {
                    print("Could not fetch \(error), \(error.userInfo)")
                }
                self?.tableView.reloadData()
            }
            let navigationController = UINavigationController(rootViewController: folderDetailsTableViewController)
            
            self?.present(navigationController, animated: true, completion: nil)
        }
        
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
        case .none:
            break
        case .insert:
            break
        @unknown default:
            break
        }
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        navigationItem.backButtonTitle = "\((currentUser?.folders?[indexPath.row] as? Folder)?.name ?? "None")"
        
        let notesCollectionView = NotesViewController()
        notesCollectionView.currentFolder = currentUser?.folders?[indexPath.row] as? Folder
        
        navigationController?.pushViewController(notesCollectionView, animated: true)
    }
}
