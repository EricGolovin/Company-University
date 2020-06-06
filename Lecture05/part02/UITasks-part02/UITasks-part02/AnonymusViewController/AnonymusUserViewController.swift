//
//  AnonymusUserViewController.swift
//  UITasks-part02
//
//  Created by Eric Golovin on 05.06.2020.
//  Copyright © 2020 com.ericgolovin. All rights reserved.
//

import UIKit

class AnonymusUserViewController: UIViewController {

    weak var delegate: RegistrationProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("anonymusViewContoller was instantiated")
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func registrationButtonTapped(_ sender: CustomButton) {
        removeFromParent()
        delegate?.presentViewController(delegate!.children.first!)
    }
    

}
