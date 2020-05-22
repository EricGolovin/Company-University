import UIKit

/*
var firstMatrix = [[1, 2], [3, 4]]
var secondMatrix = [[2, 0], [1, 2]]
*/

var firstMatrix = [Array<Int>]()
var secondMatrix = [Array<Int>]()

var resultMatrix = [Array<Int>]()

for row in 0..<10 {
    firstMatrix.append(Array<Int>())
    secondMatrix.append(Array<Int>())
    resultMatrix.append(Array<Int>())
    for _ in 0..<10 {
        firstMatrix[row].append(Int.random(in: 1...100))
        secondMatrix[row].append(Int.random(in: 1...100))
        resultMatrix[row].append(0)
    }
}



// MARK: - Using GCD


// MARK: - Non GCD
//for row in 0..<firstMatrix.count {
//    var subArray = [Int]()
//    resultMatrix.append(Array<Int>())
//    print("bufferMatrix.Count: \(resultMatrix.count) Row: \(row)")
//
//    for (secondMatrixRowIndex, _) in secondMatrix.enumerated() {
//        for (index, num) in firstMatrix[row].enumerated() {
//
//            let numFromFirstMatrix = num
//            let numFromSecondMatrix = secondMatrix[index][secondMatrixRowIndex]
//
//            let calulatedValue = numFromFirstMatrix * numFromSecondMatrix
//            subArray.append(calulatedValue)
//
//            print("firstMatrix[\(row)][\(index)]_\(numFromFirstMatrix) * secondMatrix[\(index)][\(row)]_\(numFromSecondMatrix) = \(calulatedValue)\n")
//
//            if subArray.count == 2 {
//                print("subArr[0] = \(subArray[0]), subArr[1] = \(subArray[1])")
//                resultMatrix[row].append(subArray.first! + subArray.last!)
//                subArray = []
//            }
//        }
//    }
//}


print(resultMatrix)
