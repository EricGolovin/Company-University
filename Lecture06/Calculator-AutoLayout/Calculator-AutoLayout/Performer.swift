//
//  Operations.swift
//  Calculator-AutoLayout
//
//  Created by Eric Golovin on 08.06.2020.
//  Copyright © 2020 com.ericgolovin. All rights reserved.
//

import Foundation

class Performer {
    enum Operation: String, CaseIterable {
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
    
    private var totalOperations = Operation.allCases.map { $0.rawValue }
    private var expression: String = ""
    private lazy var data: (numbers: [Double], operations: [Operation])? = {
        return formatExpression(expression)
    }()
    private var numbers: [String] = []
    private var twoNumberOperation: (first: Double?, second: Double?)
    
//    private var operation: Operation? {
//        willSet {
//            if twoNumberOperation.first == nil {
//                self.twoNumberOperation.first = makeDouble(from: numbers)
//            } else if twoNumberOperation.second == nil {
//                self.twoNumberOperation.second = makeDouble(from: numbers)
//                resultValue = performOperation(operation ?? .none, with: twoNumberOperation)
//            } else {
//                print(numbers)
//                resultValue = performOperation(operation ?? .none, with: twoNumberOperation)
//                self.twoNumberOperation.first = resultValue
//                // TODO: Fix Error Message (and do not crack app)
//                self.twoNumberOperation.second = makeDouble(from: numbers)
//            }
//            if newValue == .equal {
//                resultValue = performOperation(operation ?? .none, with: twoNumberOperation)
//            }
//            numbers = []
//        }
//    }
    
    private lazy var resultValue: Double = {
        // TODO: Fix This Junky Code
        var value = 0.0
        var operationIndex = 0
        var operationValues: (Double?, Double?) = (nil, nil)
        var flag = true
        while flag && self.data!.numbers.count >= 2 {
            if !self.data!.operations.contains(.divide) && !self.data!.operations.contains(.multiply) {
                for number in self.data!.numbers {
                    if operationValues.0 == nil {
                        operationValues.0 = number
                    } else if operationValues.1 == nil {
                        operationValues.1 = number
                        value = performOperation(self.data!.operations[operationIndex], with: operationValues)
                        operationValues = (value, nil)
                        operationIndex += 1
                    }
                }
                flag = false
            } else {
                var numberOfMultiplications = (self.data!.operations.filter { $0 == .multiply }).count
                var numberOfDivisions = (self.data!.operations.filter { $0 == .divide }).count
                
                for _ in 0..<(numberOfMultiplications + numberOfDivisions) {
                    var multiplyFirstIndex = self.data!.operations.firstIndex(of: .multiply) ?? 100
                    var divideFirstIndex = self.data!.operations.firstIndex(of: .divide) ?? 100
                    
                    if multiplyFirstIndex != 100 {
                        self.data!.operations.remove(at: multiplyFirstIndex)
                    }
                    if divideFirstIndex != 100 {
                        self.data!.operations.remove(at: divideFirstIndex)
                    }
                    if multiplyFirstIndex < divideFirstIndex {
                        if multiplyFirstIndex == 0 {
                            operationValues.0 = self.data!.numbers.remove(at: 0)
                            operationValues.1 = self.data!.numbers.remove(at: 0)
                            self.data!.numbers.insert(performOperation(.multiply, with: operationValues), at: 0)
                        } else if multiplyFirstIndex != 100 {
                            operationValues.0 = self.data!.numbers.remove(at: multiplyFirstIndex)
                            operationValues.1 = self.data!.numbers.remove(at: multiplyFirstIndex)
                            self.data!.numbers.insert(performOperation(.multiply, with: operationValues), at: multiplyFirstIndex)
                        }
                        if divideFirstIndex != 100 {
                            operationValues.0 = self.data!.numbers.remove(at: divideFirstIndex - 1)
                            operationValues.1 = self.data!.numbers.remove(at: divideFirstIndex - 1)
                            self.data!.numbers.insert(performOperation(.divide, with: operationValues), at: divideFirstIndex - 1)
                        }
                    } else {
                        if divideFirstIndex == 0 {
                            operationValues.0 = self.data!.numbers.remove(at: 0)
                            operationValues.1 = self.data!.numbers.remove(at: 0)
                            self.data!.numbers.insert(performOperation(.divide, with: operationValues), at: 0)
                        } else if divideFirstIndex != 100 {
                            operationValues.0 = self.data!.numbers.remove(at: divideFirstIndex)
                            operationValues.1 = self.data!.numbers.remove(at: divideFirstIndex)
                            self.data!.numbers.insert(performOperation(.divide, with: operationValues), at: divideFirstIndex)
                        }
                        if multiplyFirstIndex != 100 {
                            operationValues.0 = self.data!.numbers.remove(at: multiplyFirstIndex - 1)
                            operationValues.1 = self.data!.numbers.remove(at: multiplyFirstIndex - 1)
                            self.data!.numbers.insert(performOperation(.multiply, with: operationValues), at: multiplyFirstIndex - 1)
                        }
                    }
                    operationValues = (nil, nil)
                    if self.data!.numbers.count == 1 {
                        return self.data!.numbers[0]
                    }
                }
            }
        }

        return value
    }()
    
    var result: String {
        if resultValue.remainder(dividingBy: 1) == 0 {
            return "\(Int(resultValue))"
        } else {
            return String(format: "%.3f", resultValue)
        }
    }
    
    func passSymbol(_ symbol: String) {
//        if let operation = Operation(operation: symbol) {
//            self.operation = operation
//        } else {
//            numbers.append(symbol)
//        }
        expression += symbol
    }
    
    func formatExpression(_ string: String) -> (numbers: [Double], operations: [Operation]) {
        var temp = ""
        var numArray = [Double]()
        var operationArray = [Operation]()
        for char in string.lowercased() {
            if !totalOperations.contains(String(char)) {
               temp += String(char)
            } else {
                numArray.append(Double(temp) ?? 0.0)
                operationArray.append(Operation(operation: String(char)) ?? .none)
                temp = ""
            }
        }
        
        print(numArray)
        print(operationArray)
        return (numArray, operationArray)
    }
    
    func isOperator(_ symbol: String) -> Bool {
        if let _ = Operation(operation: symbol) {
            return true
        } else {
            return false
        }
    }
    
    func clear() {
//        operation = nil
        self.expression = ""
        self.data = nil
    }
    
    private func makeDouble(from array: [String]) -> Double? {
        if let value = Double(array.joined()) {
            return value
        } else {
            print("Error \"func makeDouble()\": Couldn't make double from array")
            return nil
        }
    }
    
    
    private func performOperation(_ operation: Operation, with numbers: (first: Double?, second: Double?)) -> Double {
        guard let first = numbers.first, let second = numbers.second else {
            print("Error \"performOperation\": some of the numbers is nil")
            return 0.0
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
