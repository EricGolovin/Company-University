//
//  ViewController.swift
//  Calculator-AutoLayout
//
//  Created by Eric Golovin on 07.06.2020.
//  Copyright © 2020 com.ericgolovin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var deleteKeypadButton: KeypadButton!
    @IBOutlet var keypadButtons: [KeypadButton]!
    
    @IBOutlet weak var historyTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    var operation = Operations()
    
    @IBAction func deleteKeypadTapped(_ sender: KeypadButton) {
        resultLabel.text = ""
        operation = Operations()
    }
    
    @IBAction func keypadTapped(_ sender: KeypadButton) {
        resultLabel.text! += sender.titleLabel!.text!
        
        operation.passSymbol(sender.titleLabel!.text!)
        
        switch sender.titleLabel?.text {
        case "=":
            historyTextView.text += "\n" + resultLabel.text! + "\(operation.result)"
            resultLabel.text = "Resut: \(operation.result)"
        default:
            break
        }
    }
    
    @IBAction func longPressed(_ sender: UILongPressGestureRecognizer) {
        historyTextView.text = "Calculation History"
    }
}

