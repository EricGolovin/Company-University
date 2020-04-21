enum DaysOfTheWeek: String, CaseIterable {
    case Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday
}

func getDateFormat(day: Int, month: Int, year: Int) -> String {
    var day = day, month = month, year = year
    let arrayOfIntegers = [0, 3, 2, 5, 0, 3, 5, 1, 4, 6, 2, 4]
    
    year -= month < 3 ? 1 : 0
    
    return "\(DaysOfTheWeek.allCases[(year + year / 4 - year / 100 + year / 400 + arrayOfIntegers[month - 1] + day) % 7].rawValue), 29 February"
}

func printLeapYears(from startYear: Int, to endYear: Int) {
    for year in startYear...endYear {
        if (year % 4 == 0 && (year % 100 != 0 || year == 2000)) {
            print(getDateFormat(day: 29, month: 2, year: year) + ", \(year)")
        }
    }
}

printLeapYears(from: 1800, to: 2020)
