enum DaysOfTheWeek: String, CaseIterable {
    case Sunday, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday
}

func getDateFormat(day: Int = 29, month: Int = 2, year: Int) -> String {
    var mutableYear = year
    let arrayOfIntegers = [0, 3, 2, 5, 0, 3, 5, 1, 4, 6, 2, 4]
    
    mutableYear -= month < 3 ? 1 : 0
    
    return "\(DaysOfTheWeek.allCases[(year + year / 4 - year / 100 + year / 400 + arrayOfIntegers[month - 1] + day) % 7].rawValue), 29 February"
}

func printLeapYears(from startYear: Int, to endYear: Int) {
    for year in startYear...endYear {
        if let year = checkForLeap(year: year) {
            print(year)
        }
    }
}

func checkForLeap(year: Int) -> String? {
    if (year % 4 == 0 && (year % 100 != 0 || year == 2000)) {
        return getDateFormat(year: year) + ", \(year)"
    }
    return nil
}

printLeapYears(from: 1800, to: 2020)
