//
//  NotesCollectionViewController.swift
//  Notes-HW
//
//  Created by Eric Golovin on 7/8/20.
//

import UIKit



class NotesCollectionViewController: UICollectionViewController {
    
    // MARK: - Cell Identifiers
    private let noteCellIdentifier = "NoteCell"
    private let sectionInsets = UIEdgeInsets(top: 30.0,
                                             left: 20.0,
                                             bottom: 30.0,
                                             right: 20.0)
    private let itemsPerRow: CGFloat = 2
    

    // MARK: - Properties
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
    
    var currentFolder: Folder?
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // MARK: - Actions
    @IBAction func addNoteTapped(_ sender: UIBarButtonItem) {
        
    }
    
    @IBAction func filterTapped(_ sender: UIBarButtonItem) {
        
    }
    
    // MARK: - UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {

        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 10
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: noteCellIdentifier, for: indexPath) as! NoteCollectionViewCell
    
        cell.noteImageView.image = UIImage(named: "note")
        cell.noteTitle.text = "Title"
        cell.noteCreationDate.text = "Today"
    
        return cell
    }

    // MARK: - UICollectionViewDelegate
    
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
