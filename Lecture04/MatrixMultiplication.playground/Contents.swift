import UIKit

var firstMatrix = [[1, 2], [3, 4]]
var secondMatrix = [[2, 0], [1, 2]]

var bufferMatrix = [Array<Int>]()

for (index, _) in firstMatrix.enumerated() {
    let queue = DispatchQueue(label: "RowQueue#\(index)")
//    let group = DispatchGroup()
//    bufferMatrix.append(Array<Int>())
    var arrayToAdd = Array<Int>()
    
    for (i, num) in firstMatrix[index].enumerated() {
        queue.sync {
//            bufferMatrix.append(Array<Int>())
            
            queue.async {
                let firstMatrixValue = num
                let seconMatrixValue = secondMatrix[i][index]
                print("\(firstMatrixValue) * \(seconMatrixValue) = \(firstMatrixValue * seconMatrixValue)" )
                
                arrayToAdd.append(firstMatrixValue * seconMatrixValue)
            }
        }
    }
    
    bufferMatrix.append(arrayToAdd)
    
//    group.notify(queue: DispatchQueue.main) {
////        bufferMatrix[index][0] = bufferMatrix[index].reduce(0, +)
//    }
}

print(bufferMatrix)
