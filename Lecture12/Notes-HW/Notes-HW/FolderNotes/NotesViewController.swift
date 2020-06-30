//
//  NotesViewController.swift
//  Notes-HW
//
//  Created by Eric Golovin on 6/30/20.
//

import UIKit

class NotesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
    
    private var collectionView: UICollectionView!
    var currentFolder: Folder?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
        layout.itemSize = CGSize(width: view.bounds.width / 2 - 20, height: 248)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "NoteCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        
        collectionView.frame = view.bounds
        
        collectionView.backgroundColor = .white
        
        self.view.addSubview(collectionView)
        
        let addNoteImage = UIImage(systemName: "note.text.badge.plus")?.withRenderingMode(.alwaysOriginal)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: addNoteImage, style: .plain, target: self, action: #selector(addNote))
    }
    
    
    // MARK: - Actions
    
    @objc func addNote() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let newNote = Note(context: managedContext)
        let noteViewController = UIStoryboard(name: "NoteTableViewController", bundle: nil).instantiateViewController(identifier: "NoteTableViewController") as NoteTableViewController
        noteViewController.currentNote = newNote
        noteViewController.completeAction = {
            self.currentFolder?.addToNotes(newNote)
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Could not fetch \(error), \(error.userInfo)")
            }
            self.collectionView.reloadData()
        }
        
        let navigationController = UINavigationController(rootViewController: noteViewController)
        
        present(navigationController, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        currentFolder?.notes?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! NoteCollectionViewCell
        
        let note = currentFolder?.notes?[indexPath.row] as! Note
        
        cell.noteTitle.text = note.name
        cell.noteCreationDate.text = dateFormatter.string(from: note.creationDate!)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        let managedContext = appDelegate.persistentContainer.viewContext
            
            let configuration = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { action in
                let viewMenu = UIAction(title: "View", image: UIImage(systemName: "eye.fill"), identifier: UIAction.Identifier(rawValue: "view")) { _ in
                    let noteViewController = UIStoryboard(name: "NoteTableViewController", bundle: nil).instantiateViewController(identifier: "NoteTableViewController") as NoteTableViewController
                    noteViewController.currentNote = self.currentFolder?.notes?[indexPath.row] as? Note
                    noteViewController.completeAction = {
                        do {
                            try managedContext.save()
                        } catch let error as NSError {
                            print("Could not fetch \(error), \(error.userInfo)")
                        }
                        self.collectionView.reloadData()
                    }
                    let navigationController = UINavigationController(rootViewController: noteViewController)
                    self.present(navigationController, animated: true, completion: nil)
                }
                
                let delete = UIAction(title: "Delete", image: UIImage(systemName: "trash.fill"), identifier: UIAction.Identifier(rawValue: "delete")) { _ in
                    guard let noteToDelete = self.currentFolder?.notes?[indexPath.row] as? Note else {
                        return
                    }
                    
                    self.currentFolder?.removeFromNotes(noteToDelete)
                    
                    do {
                        try managedContext.save()
                    } catch let error as NSError {
                        print("Could not fetch \(error), \(error.userInfo)")
                    }
                    
                    self.collectionView.reloadData()
                }
                
                return UIMenu(title: "Options", image: nil, identifier: nil, children: [viewMenu, delete])
            }
            
            return configuration
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return 
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let noteViewController = UIStoryboard(name: "NoteTableViewController", bundle: nil).instantiateViewController(identifier: "NoteTableViewController") as NoteTableViewController
        noteViewController.currentNote = self.currentFolder?.notes?[indexPath.row] as? Note
        noteViewController.completeAction = {
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Could not fetch \(error), \(error.userInfo)")
            }
            self.collectionView.reloadData()
        }
        let navigationController = UINavigationController(rootViewController: noteViewController)
        self.present(navigationController, animated: true, completion: nil)
    }

}
