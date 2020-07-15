//
//  StartViewController.swift
//  Notes-HW
//
//  Created by Eric Golovin on 7/9/20.
//

import UIKit

class StartViewController: UIViewController {
    
    // MARK: - Identifiers
    private let userCellIdentifier = "UserCell"
    private let loginSegue = "loginSegue"

    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    private let sectionInsets = UIEdgeInsets(top: 30.0,
                                             left: 20.0,
                                             bottom: 30.0,
                                             right: 20.0)
    private let itemsPerRow: CGFloat = 2
    private var userDefaultsManager = UserDefaultsManager.manager
    
    private var logins = [String]()
    private var images = [UIImage]()
    private var selectedIndexPath: IndexPath?
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureCollectionView()
        loadUserFromMemory()
    }
    
    func configureCollectionView() {
        collectionView.layer.cornerRadius = 20
        collectionView.clipsToBounds = false
        collectionView.layer.shadowColor = UIColor.gray.cgColor
        collectionView.layer.shadowRadius = 10
        collectionView.layer.shadowOpacity = 1
        collectionView.layer.shadowOffset = CGSize(width: 1, height: 5)
    }
    
    func loadUserFromMemory() {
        guard let loadedUsersData = userDefaultsManager.loadUsers() else {
            print("No saved users")
            return
        }
        logins = loadedUsersData.logins
        images = loadedUsersData.images
        collectionView.reloadData()
    }
    
    
    // MARK: - Actions
    @IBAction func createUserTapped(_ sender: UIButton) {
    }
    
    @IBAction func userDoubleTapped(_ sender: UITapGestureRecognizer) {
        let resetAlertAction = UIAlertAction(title: "Reset Users", style: .destructive, handler: { _ in
            self.userDefaultsManager.deleleAllUsers()
            self.logins.removeAll()
            self.images.removeAll()
            self.collectionView.reloadData()
        })
        let reloadAlertAction = UIAlertAction(title: "Reload CollectionView", style: .default, handler: { _ in
            self.loadUserFromMemory()
            self.collectionView.reloadData()
        })
        let alertController = UIAlertController(title: "Perform Action", message: nil, preferredStyle: .actionSheet)
        alertController.addAction(resetAlertAction)
        alertController.addAction(reloadAlertAction)
        
        present(alertController, animated: true)
        
    }
}

// MARK: - Collection View Flow Layout Delegate
extension StartViewController: UICollectionViewDelegateFlowLayout {
    
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

// MARK: - Collection View
extension StartViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return logins.count == 0 ? 1 : logins.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard logins.count > 0 else {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: userCellIdentifier, for: indexPath) as? UserCollectionViewCell {
                
                let largeConfiguration = UIImage.SymbolConfiguration(scale: .large)
                let largeSymbolImage = UIImage(systemName: "xmark.circle", withConfiguration: largeConfiguration)
                
                cell.userImageView.image = largeSymbolImage
                cell.userImageView.contentMode = .scaleAspectFit
                
                return cell
            } else {
                return UICollectionViewCell()
            }
        }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: userCellIdentifier, for: indexPath) as? UserCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.userImageView.image = images[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard logins.count > 0 else {
            return
        }
        selectedIndexPath = indexPath
        performSegue(withIdentifier: loginSegue, sender: self)
    }
}

// MARK: - Navigation
extension StartViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case loginSegue:
            guard let loginUserVC = segue.destination as? LoginViewController,
                  let indexPath = selectedIndexPath,
                  let selectedCell = collectionView.cellForItem(at: indexPath) as? UserCollectionViewCell,
                  let image = selectedCell.userImageView.image else {
                return
            }
            loginUserVC.userData = UserLoginData(image: image, username: logins[indexPath.row])
        default:
            break
        }
        selectedIndexPath = nil
    }
}
