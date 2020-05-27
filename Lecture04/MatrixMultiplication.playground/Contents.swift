import UIKit

let maxMatrixElement = 10
let numberOfQueues = 5
let matrixSize = 10

if matrixSize % 2 != 0 {
    fatalError("Please, enter even matrix size")
}

enum MatrixContentOptions {
    case zero
    case random(Int)
}

func prepareMatrixesOf(size: Int, resultMatrix: inout [[Int]]) -> (first: [[Int]], second: [[Int]]) {
    var result = (first: [[Int]](), second: [[Int]]())
    
    result.first = Array.make2D(with: .random(maxMatrixElement), size: size)
    result.second = Array.make2D(with: .random(maxMatrixElement), size: size)
    resultMatrix = Array.make2D(with: .zero, size: size)

    return result
}

var queues = { (number: Int) -> Array<DispatchQueue> in
    var result = Array<DispatchQueue>()
    for i in 0..<number {
        result.append(DispatchQueue(label: "queue\(i)", attributes: .concurrent))
    }
    return result
}(numberOfQueues)

var dispatchGroup = DispatchGroup()

//var matrixes = (first: [[1, 2], [3, 4]], second: [[2, 0], [1, 2]])
//var resultMatrix = Array.make2D(with: .zero, size: 2)

var gcdTiming = 0.0
var linearTiming = 0.0

var resultMatrix = [[Int]]()
var matrixes = prepareMatrixesOf(size: matrixSize, resultMatrix: &resultMatrix)

resultMatrix.forEach { print($0) }

// MARK: - Using GCD
gcdTiming = CFAbsoluteTimeGetCurrent()
for (i, row) in matrixes.first.enumerated() {
    for j in 0..<row.count {
        for k in 0..<row.count {
//            print(k % queues.count)
            queues[k % queues.count].async(group: dispatchGroup) {
                resultMatrix[i][j] += matrixes.first[i][k] * matrixes.second[k][j]
            }
        }
    }
}
gcdTiming = CFAbsoluteTimeGetCurrent() - gcdTiming

dispatchGroup.notify(queue: .main) {
    print("Result GCD:")
    resultMatrix.forEach { print($0) }
    resultMatrix = Array.make2D(with: .zero, size: matrixSize)
    
    // MARK: - Not using GCD
    linearTiming = CFAbsoluteTimeGetCurrent()
    for (i, row) in matrixes.first.enumerated() {
        for (j, _) in row.enumerated() {
            for k in 0..<row.count {
                resultMatrix[i][j] += matrixes.first[i][k] * matrixes.second[k][j]
            }
        }
    }
    linearTiming = CFAbsoluteTimeGetCurrent() - linearTiming
    print("Result Linear:")
    resultMatrix.forEach { print($0) }
    
    print("\nGCD multiplication took \(gcdTiming)")
    print("Linear multiplication took \(linearTiming)\n")
}

extension Array where Element == Int {
    static func make2D(with option: MatrixContentOptions, size: Int) -> [[Int]] {
        return (0..<size).map { _ in (0..<size).map { _ in
            if case .random(let value) = option { return Int.random(in: 0...value) } else { return 0 }
            } }
    }
}
