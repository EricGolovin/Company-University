//
//  PhotoViewController.swift
//  Filtery
//
//  Created by Eric Golovin on 30.07.2020.
//

import UIKit

class PhotoViewController: UIViewController {
    
    var image: UIImage?
    var colors: Dictionary<String, Int>?

    @IBOutlet weak var imageView: UIImageView!
    
    var completion: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let image = image {
            imageView.image = image
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        completion?()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
