//
//  ViewController.swift
//  MatrixCalculator
//
//  Created by Eric Golovin on 04.06.2020.
//  Copyright © 2020 com.ericgolovin. All rights reserved.
//

import UIKit

enum MatrixContentOptions {
    case zero
    case random(Int)
}

class ViewController: UIViewController {
    
    @IBOutlet weak var maxElementTextField: UITextField!
    @IBOutlet weak var numberOfQueuesTextField: UITextField!
    @IBOutlet weak var matrixSizeTextField: UITextField!
    @IBOutlet var textFields: [UITextField]!
    
    
    @IBOutlet weak var randomButton: UIButton!
    @IBOutlet weak var linearButton: UIButton!
    @IBOutlet weak var gcdButton: UIButton!
    
    @IBOutlet weak var matrix01TextView: UITextView!
    @IBOutlet weak var matrix02TextView: UITextView!
    @IBOutlet weak var resultMatrixTextView: UITextView!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    var dispatchGroup = DispatchGroup()
    var queues: [DispatchQueue]!
    var matrixes: (first: [[Int]], second: [[Int]])! {
        didSet {
            linearButton.isEnabled = true
            gcdButton.isEnabled = true
        }
    }
    var resultMatrix = [[Int]]()
    
    var matrixMaxElement: Int!
    var matrixSize: Int!
    var numberOfQueues: Int!
    var time: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textFields.forEach { $0.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged) }
        
        linearButton.isEnabled = false
        gcdButton.isEnabled = false
        
        updateUI()
    }
    
    @IBAction func generateMatrixes(_ sender: UIButton) {
        guard let matrixMaxElement = Int(maxElementTextField.text ?? "_"), let numberOfQueues = Int(numberOfQueuesTextField.text ?? "_"), let matrixSize = Int(matrixSizeTextField.text ?? "_") else {
            print("Warning: Some textFields have wrong input")
            return
        }
        view.endEditing(true)
        
        if matrixSize % 2 != 0 {
            matrix01TextView.text = "Change \(matrixSize) to even Number"
            return
        }
        
        self.matrixMaxElement = matrixMaxElement
        self.numberOfQueues = numberOfQueues
        self.matrixSize = matrixSize
        self.queues = {
            var result = Array<DispatchQueue>()
            for i in 0..<self.numberOfQueues {
                result.append(DispatchQueue(label: "queue\(i)" ,attributes: .concurrent))
            }
            return result
        }()
        
        matrixes = prepareMatrixesOf(size: matrixSize, maxElement: matrixMaxElement)
        resultMatrix = Array.make2D(with: .zero, size: matrixSize)
        
        matrix01TextView.text = getStringMatrix(from: matrixes?.first ?? [[]])
        matrix02TextView.text = getStringMatrix(from: matrixes?.second ?? [[]])
        updateUI()
    }
    
    @IBAction func calculateLinear(_ sender: UIButton) {
        guard let matrixes = self.matrixes else {
            print("Error: Matrixes are nil")
            return
        }
        
        timeLabel.text = "Previous Time: \(self.time)\n"
        
        time = CFAbsoluteTimeGetCurrent()
        for (i, row) in matrixes.first.enumerated() {
            for (j, _) in row.enumerated() {
                for k in 0..<row.count {
                    resultMatrix[i][j] += matrixes.first[i][k] * matrixes.second[k][j]
                }
            }
        }
        time = CFAbsoluteTimeGetCurrent() - time
        
        timeLabel.text! += "Current Time: \(time)"
        resultMatrixTextView.text = getStringMatrix(from: resultMatrix)
    }
    
    @IBAction func calculateGCD(_ sender: UIButton) {
        guard let matrixes = self.matrixes else {
            print("Error: Matrixes are nil")
            return
        }
        
        timeLabel.text = "Previous Time: \(self.time)\n"
        
        time = CFAbsoluteTimeGetCurrent()
        
        let count = matrixes.first.count
        let range = count / queues.count
        var counter = 0
        
        for q in 0..<queues.count {
            queues[q].async {
                for i in (range * q)..<(range * q + 1) {
                    for j in 0..<count {
                        var sum = 0
                        for k in 0..<count {
                            sum += matrixes.first[i][k] * matrixes.second[k][j]
                        }
                        DispatchQueue.main.async {
                            self.resultMatrix[i][j] = sum
                        }
                    }
                }
                counter += 1
                if counter == self.queues.count {
                    self.time = CFAbsoluteTimeGetCurrent() - self.time
                    DispatchQueue.main.async {
                        self.timeLabel.text = "Time: \(self.time)"
                        self.resultMatrixTextView.text = self.getStringMatrix(from: self.resultMatrix)
                        self.changeButtonsState()
                    }
                }
            }
        }
        
        
//        time = CFAbsoluteTimeGetCurrent() - time
        
        changeButtonsState()
        
        //        dispatchGroup.notify(queue: .main) {
        //            self.timeLabel.text! += "Current Time: \(self.time)"
        //            self.resultMatrixTextView.text = self.getStringMatrix(from: self.resultMatrix)
        //            self.changeButtonsState()
        //        }
//        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
//            self.timeLabel.text = "Time: \(self.time)"
//            self.resultMatrixTextView.text = self.getStringMatrix(from: self.resultMatrix)
//            self.changeButtonsState()
//        })
    }
    
    @IBAction func userTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @objc func textFieldDidChange(_ sender: UITextField) {
        self.linearButton.isEnabled = false
        self.gcdButton.isEnabled = false
    }
    
    func updateUI() {
        if maxElementTextField.text == "" {
            maxElementTextField.text = "9"
        }
        if numberOfQueuesTextField.text == "" {
            numberOfQueuesTextField.text = "5"
        }
        if matrixSizeTextField.text == "" {
            matrixSizeTextField.text = "10"
        }
    }
    
    func prepareMatrixesOf(size: Int, maxElement: Int) -> (first: [[Int]], second: [[Int]]) {
        var result = (first: [[Int]](), second: [[Int]]())
        
        result.first = Array.make2D(with: .random(maxElement), size: size)
        result.second = Array.make2D(with: .random(maxElement), size: size)
        
        return result
    }
    
    func getStringMatrix(from matrix: [[Int]]) -> String {
        var result = ""
        for i in matrix {
            for q in i {
                result += "\(q)"
            }
            result += "\n"
        }
        return result
    }
    
    func changeButtonsState() {
        randomButton.isEnabled.toggle()
        linearButton.isEnabled.toggle()
        gcdButton.isEnabled.toggle()
    }
}

extension Array where Element == Int {
    static func make2D(with option: MatrixContentOptions, size: Int) -> [[Int]] {
        return (0..<size).map { _ in (0..<size).map { _ in
            if case .random(let value) = option { return Int.random(in: 0...value) } else { return 0 }
            } }
    }
}
