import UIKit

enum CoordinateType {
    case degree(deg: Int, min: Int)
    case radian(Double)
}

enum Values {
    case km
    case meter
    case radian
}

enum Coordinate {
    case coordinate(CoordinateType)
    indirect case distanceBetween(Coordinate, Coordinate)
    
    func distanceInDegreesTo(coordinate: Coordinate) -> Coordinate {
        if case let .coordinate(firstType) = self, case let .coordinate(secondType) = coordinate {
            if case let .degree(firstDegree, firstMinute) = firstType, case let .degree(secondDegree, secondMinute) = secondType {
                var minutes = firstMinute - secondMinute
                if minutes < 0 {
                    minutes += 60
                    return Coordinate.coordinate(.degree(deg: firstDegree - secondDegree - 1, min: minutes))
                } else {
                    return Coordinate.coordinate(.degree(deg: firstDegree - secondDegree, min: minutes))
                }
            }
        }
        print("Error: not passed .distanceBetween")
        return Coordinate.coordinate(.degree(deg: 0, min: 0))
    }
    
    func distance(coordinate: Coordinate, type: Values) -> String {
//        switch coordinate {
//        case .coordinate(_):
//            break
//        case let .distanceBetween(first, second):
//
//        }
        return ""
    }
    
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
    
    func distanceInMetersAndKmTo(coordinate: Coordinate) -> (km: Double, m: Double) {
        let inDegree = self.distanceInDegreesTo(coordinate: coordinate)
        
        if case let .coordinate(.degree(degree, minute)) = inDegree {
            let meterDegree = Double(degree) * 111.2
            let meterMinute = Double(minute) * 1.835
            return (km: meterDegree * meterMinute / 1000, m: meterDegree * meterMinute)
        }
        
        return (km: 0.0, m: 0.0)
    }
}

let SanFrancisco = Coordinate.coordinate(.degree(deg: 37, min: 19))
let LosAngeles = Coordinate.coordinate(.degree(deg: 33, min: 42))

let distanceInDegrees = SanFrancisco.distanceInDegreesTo(coordinate: LosAngeles)
let distanceInRadians = SanFrancisco.distanceInRadiansTo(coordinate: LosAngeles)
let distanceInMetersKilometers = SanFrancisco.distanceInMetersAndKmTo(coordinate: LosAngeles)

if case let .coordinate(.degree(degree, minute)) = distanceInDegrees {
    print("Degree: \(degree), Minute: \(minute)")
}

if case let .coordinate(.radian(radian)) = distanceInRadians {
    print("Distance in Radians: \(radian)")
}

print("In meters: \(distanceInMetersKilometers.m), in Kilometers: \(distanceInMetersKilometers.km)")

