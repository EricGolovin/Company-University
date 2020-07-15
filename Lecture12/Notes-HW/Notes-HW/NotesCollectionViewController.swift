//
//  NotesCollectionViewController.swift
//  Notes-HW
//
//  Created by Eric Golovin on 7/8/20.
//

import UIKit
import CoreData

class NotesCollectionViewController: UICollectionViewController {
    
    // MARK: - Identifiers
    private let noteCellIdentifier = "NoteCell"
    private let addNoteSegueIdentifier = "addNoteSegue"

    // MARK: - Properties
    var currentFolder: Folder?
    var selectedIndexPath: IndexPath?
    var coreDataStack = CoreDataStack.stack
    
    lazy var nameSortDescriptor: NSSortDescriptor = {
        let compareSelector = #selector(NSString.localizedStandardCompare(_:))
        return NSSortDescriptor(key: #keyPath(Note.name
                                    ), ascending: true, selector: compareSelector)
    }()
    lazy var creationDateSortDescriptor: NSSortDescriptor = {
        return NSSortDescriptor(key: #keyPath(Note.creationDate), ascending: true)
    }()
    
    private let sectionInsets = UIEdgeInsets(top: 30.0,
                                             left: 20.0,
                                             bottom: 30.0,
                                             right: 20.0)
    private let itemsPerRow: CGFloat = 2
    private var cellInitialBackgroundColor: UIColor?
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // MARK: - Actions
    @IBAction func addNoteTapped(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: addNoteSegueIdentifier, sender: self)
    }
    
    @IBAction func filterTapped(_ sender: UIBarButtonItem) {
        sortNotes()
    }
    
    // MARK: - UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentFolder!.notes!.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: noteCellIdentifier, for: indexPath) as? NoteCollectionViewCell,
              let note = currentFolder?.notes?[indexPath.row] as? Note else {
            return UICollectionViewCell()
        }
    
        cell.noteImageView.image = UIImage(named: "note")
        cell.noteTitle.text = note.name
        cell.noteCreationDate.text = note.getStringDate(dateStyle: .short, timeStyle: .short)
        
        return cell
    }

    // MARK: - UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        
        animateCellBackground(collectionView.cellForItem(at: indexPath)!, with: .gray)
        
        performSegue(withIdentifier: addNoteSegueIdentifier, sender: self)
    }
}

// MARK: - Collection View Flow Layout Delegate
extension NotesCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
}

// MARK: - Animations
extension NotesCollectionViewController {
    
    func animateCellBackground(_ cell: UICollectionViewCell, with color: UIColor) {
        cellInitialBackgroundColor = cell.backgroundColor
        UIView.animate(withDuration: 1, delay: 0.0, options: [], animations: {
            cell.backgroundColor = color
        })
    }
}

// MARK: - Navigation
extension NotesCollectionViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case addNoteSegueIdentifier:
            guard let noteVC = (segue.destination as? UINavigationController)?.viewControllers.first as? NoteDetailTableViewController else {
                return
            }
            if let indexPath = selectedIndexPath,
               let selectedNote = currentFolder?.notes?[indexPath.row] as? Note {
                // Existing Note
                noteVC.currentNote = selectedNote
                noteVC.interfaceCompletionAction = {
                    self.animateCellBackground(self.collectionView.cellForItem(at: indexPath)!, with: self.cellInitialBackgroundColor!)
                }
            } else {
                // New Note
                let newNote = Note(context: coreDataStack.managedContext)
                currentFolder?.addToNotes(newNote)
                noteVC.currentNote = newNote
            }
            noteVC.completeAction = {
                self.coreDataStack.saveContext()
                self.collectionView.reloadData()
            }

        default:
            break
        }
        selectedIndexPath = nil
    }
}

// MARK: - Helper Methods
extension NotesCollectionViewController {
    
    func configureNewNote(with folder: Note) {
        
    }
    
    func filterViewController(sortDescriptor: NSSortDescriptor) {
        let fetchRequest = NSFetchRequest<Note>(entityName: "Note")
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            let results = try coreDataStack.managedContext.fetch(fetchRequest)
            currentFolder?.notes = NSOrderedSet(array: results)
            collectionView.reloadData()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    
    func sortNotes() {
        let alert = UIAlertController(title: "Sort Notes", message: "Choose sort option", preferredStyle: .actionSheet)
        
        let byNameAction = UIAlertAction(title: "by Name", style: .default, handler: { _ in
            self.filterViewController(sortDescriptor: self.nameSortDescriptor)
        })
        
        let byDateAction = UIAlertAction(title: "by Date", style: .default, handler: { _ in
            self.filterViewController(sortDescriptor: self.creationDateSortDescriptor)
        })
        
        alert.addAction(byNameAction)
        alert.addAction(byDateAction)
        present(alert, animated: true, completion: nil)
    }
    
}
