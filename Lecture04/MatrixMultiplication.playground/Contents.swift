import UIKit

var firstMatrix = [[1, 2], [3, 4]]
var secondMatrix = [[2, 0], [1, 2]]

var bufferMatrix = [Array<Int>]()

for (index, _) in firstMatrix.enumerated() {
    let group = DispatchGroup()
    bufferMatrix.append(Array<Int>())
    
    for (i, num) in firstMatrix[index].enumerated() {
        DispatchQueue(label: "RowQueue#\(index)-\(i)").async(group: group) {
            let firstMatrixValue = num
            let seconMatrixValue = secondMatrix[i][index]
            print("\(firstMatrixValue) + \(seconMatrixValue) = \(firstMatrixValue + seconMatrixValue)" )
            
            bufferMatrix[index].append(firstMatrixValue + seconMatrixValue)
        }
    }
    
    
    group.notify(queue: DispatchQueue.main) {
        bufferMatrix[index][0] = bufferMatrix[index].reduce(0, +)
    }
}

print(bufferMatrix[0][0])
