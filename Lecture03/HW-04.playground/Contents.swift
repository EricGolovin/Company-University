import UIKit

enum CoordinateType {
    case degree(Int, Int)
    case radian(Double)
}

enum Coordinate {
    case coordinate(CoordinateType)
    indirect case distanceBetween(Coordinate, Coordinate)
    
    init?(distanceBetweeenInRadian: Coordinate) {
        if let inDegree = Coordinate.init(distanceBetweenInDegrees: distanceBetweeenInRadian) {
            switch inDegree {
            case let .coordinate(degreeType):
                if case let .degree(degree, minute) = degreeType {
                    let decimalRepresentation: Double = Double(degree + minute) / 60
                    self = .coordinate(.radian(decimalRepresentation * Double.pi / 180))
                    break
                }
                fallthrough
            default:
                return nil
            }
        } else {
            return nil
        }
    }
    
    init?(distanceBetweenInDegrees: Coordinate) {
        if case let .distanceBetween(first, second) = distanceBetweenInDegrees {
            if case let .coordinate(firstType) = first, case let .coordinate(secondType) = second {
                if case let .degree(firstDegree, firstMinute) = firstType, case let .degree(secondDegree, secondMinute) = secondType {
                    var minutes = firstMinute - secondMinute
                    if minutes < 0 {
                        minutes += 60
                        self = Coordinate.coordinate(.degree(firstDegree - secondDegree - 1, minutes))
                    } else {
                        self = Coordinate.coordinate(.degree(firstDegree - secondDegree, minutes))
                    }
                }
            }
        } else {
            print("Error: not passed .distanceBetween")
            return nil
        }
        // TODO: fix "'self' used before 'self.init' call or assignment to 'self'"
    }
}

let SanFrancisco = Coordinate.coordinate(.degree(37, 19))
let LosAngeles = Coordinate.coordinate(.degree(33, 42))

let distanceInDegrees = Coordinate.init(distanceBetweenInDegrees: .distanceBetween(SanFrancisco, LosAngeles))
//let distanceInRadians = Coordinate.init(distanceBetweeenInRadian:.distanceBetween(SanFrancisco, LosAngeles))

if let distance = distanceInDegrees {
    switch distance {
    case let .coordinate(.degree(degree, minute)):
        print("Degree: \(degree), Minute: \(minute)")
    default:
        break
    }
}

//if let distance = distanceInRadians, case let .coordinate(radian) = distance {
//    print("Distance in Radians: \(radian.self)")
//}
