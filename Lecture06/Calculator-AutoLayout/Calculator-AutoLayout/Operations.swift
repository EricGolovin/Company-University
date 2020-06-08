//
//  Operations.swift
//  Calculator-AutoLayout
//
//  Created by Eric Golovin on 08.06.2020.
//  Copyright © 2020 com.ericgolovin. All rights reserved.
//

import Foundation

class Operations {
    enum Operation: String {
        case divide = "/"
        case multiply = "x"
        case minus = "-"
        case plus = "+"
        case equal = "="
        case none

        init?(operation: String) {
            switch operation.lowercased() {
            case Operation.divide.rawValue:
                self = .divide
            case Operation.multiply.rawValue:
                self = .multiply
            case Operation.minus.rawValue:
                self = .minus
            case Operation.plus.rawValue:
                self = .plus
            case Operation.equal.rawValue:
                self = .equal
            default:
                return nil
            }
        }
    }
    
    private var numbers: [String] = []
    private var twoNumberOperation: (first: Double?, second: Double?)
    private var operation: Operation? {
        willSet {
            if twoNumberOperation.first == nil {
                self.twoNumberOperation.first = makeDouble(from: numbers)
                numbers = []
            } else if twoNumberOperation.second == nil {
                self.twoNumberOperation.second = makeDouble(from: numbers)
                resultValue = performOperation(operation ?? .none, with: twoNumberOperation)
                numbers = []
            }
            if newValue == .equal {
                resultValue = performOperation(operation ?? .none, with: twoNumberOperation)
            }

        }
    }
    private var resultValue: Double = 0.0
    
    var result: Double {
        resultValue
    }
    
    func passSymbol(_ symbol: String) {
        if let operation = Operation(operation: symbol) {
            self.operation = operation
        } else {
            numbers.append(symbol)
        }
    }
    
    private func makeDouble(from array: [String]) -> Double? {
        if let firtValue = Double(array.joined()) {
            return firtValue
        } else {
            print("Error: Couldn't make double from array")
            return nil
        }
    }
    
    
    private func performOperation(_ operation: Operation, with numbers: (first: Double?, second: Double?)) -> Double {
        guard let first = numbers.first, let second = numbers.second else {
            fatalError("Error: Operation Values are nil")
        }
        switch operation {
        case .divide:
            return first / second
        case .multiply:
            return first * second
        case .minus:
            return first - second
        case .plus:
            return first + second
        default:
            print("No such operation")
            return 0.0
        }
    }
}
