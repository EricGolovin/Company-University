import Foundation

public extension Array where Element == Array<Int> {
    func printPyramide() {
        for subArray in self {
            var valueToPrint = ""
            for i in subArray {
                valueToPrint += "\(i)"
            }
            print(valueToPrint)
        }
    }
}
