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
    
    @IBOutlet var keypadOperationButtons: [KeypadButton]!
    
    @IBOutlet weak var historyTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        longPressed(UILongPressGestureRecognizer())
    }
    
    var operation: Performer!
    
    @IBAction func deleteKeypadTapped(_ sender: KeypadButton) {
        resultLabel.text = "0"
        operation = Performer()
    }
    
    @IBAction func keypadTapped(_ sender: KeypadButton) {
        if resultLabel.text!.contains("Result") || resultLabel.text! == "0" {
            resultLabel.text = ""
            operation = Performer()
        }
        
        if operation.isOperator(sender.titleLabel!.text!) {
            keypadOperationButtons.forEach { $0.isEnabled = false }
        } else {
            keypadOperationButtons.forEach { $0.isEnabled = true }
        }
        
        resultLabel.text! += sender.titleLabel!.text!
        operation.passSymbol(sender.titleLabel!.text!)
        
        switch sender.titleLabel?.text {
        case "=":
            historyTextView.text += "\n" + resultLabel.text! + operation.result
            resultLabel.text = "Result: " + operation.result
            operation.clear()
        default:
            break
        }
    }
    
    @IBAction func longPressed(_ sender: UILongPressGestureRecognizer) {
        historyTextView.text = "Calculation History\n"
        for _ in historyTextView.text {
            historyTextView.text += "-"
        }
    }
}

