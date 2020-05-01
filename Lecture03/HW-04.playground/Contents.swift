import UIKit

enum CoordinateType {
    case degree(Int, Int)
    case radian(Double)
}

enum Coordinate {
    case coordinate(CoordinateType)
    indirect case distanceBetween(Coordinate, Coordinate)
    
    func distanceInRadiansTo(coordinate: Coordinate) -> Coordinate {
        let inDegree = self.distanceInDegreesTo(coordinate: coordinate)
        
        switch inDegree {
        case let .coordinate(degreeType):
            if case let .degree(degree, minute) = degreeType {
                let decimalRepresentation: Double = Double(degree + minute) / 60
                return Coordinate.coordinate(.radian(decimalRepresentation * Double.pi / 180))
            }
            fallthrough
        default:
            return Coordinate.coordinate(.radian(0))
        }
    }
    
    func distanceInDegreesTo(coordinate: Coordinate) -> Coordinate {
        if case let .coordinate(firstType) = self, case let .coordinate(secondType) = coordinate {
            if case let .degree(firstDegree, firstMinute) = firstType, case let .degree(secondDegree, secondMinute) = secondType {
                var minutes = firstMinute - secondMinute
                if minutes < 0 {
                    minutes += 60
                    return Coordinate.coordinate(.degree(firstDegree - secondDegree - 1, minutes))
                } else {
                    return Coordinate.coordinate(.degree(firstDegree - secondDegree, minutes))
                }
            }
        }
        print("Error: not passed .distanceBetween")
        return Coordinate.coordinate(.degree(0, 0))
    }
}

let SanFrancisco = Coordinate.coordinate(.degree(37, 19))
let LosAngeles = Coordinate.coordinate(.degree(33, 42))

let distanceInDegrees = SanFrancisco.distanceInDegreesTo(coordinate: LosAngeles)
let distanceInRadians = SanFrancisco.distanceInRadiansTo(coordinate: LosAngeles)

if case let .coordinate(.degree(degree, minute)) = distanceInDegrees {
    print("Degree: \(degree), Minute: \(minute)")
}

if case let .coordinate(.radian(radian)) = distanceInRadians {
    print("Distance in Radians: \(radian)")
}

