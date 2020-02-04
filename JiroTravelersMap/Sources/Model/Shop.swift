import Foundation

struct Shop: Model, Identifiable {
    let id: Int
    let kind: Kind
    let name: String
    let prefecture: Prefecture
    let address: String
    let location: Location
    let openingHours: OpeningHours
}

extension Shop {
    var openingToday: String {
        let today = openingHours.today
        if today.isEmpty { return "休" }
        return today.map { $0.description }.joined(separator: "\n")
    }
}

// MARK: -
extension Shop {
    enum Kind: String, Model {
        case origin
        case inspired
    }
}

// MARK: -
extension Shop {
    struct OpeningHours: Model {
        let monday: [Time]
        let tuesday: [Time]
        let wednesday: [Time]
        let thursday: [Time]
        let friday: [Time]
        let saturday: [Time]
        let sunday: [Time]
        let holiday: [Time]
    }
}

extension Shop.OpeningHours {
    var today: [Time] { forDate(Date()) }
}

extension Shop.OpeningHours {
    func forDate(_ date: Date) -> [Time] {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: "Asia/Tokyo")!
        let comp = calendar.dateComponents([.weekday], from: date)
        switch comp.weekday {
        case 1: return sunday
        case 2: return monday
        case 3: return tuesday
        case 4: return wednesday
        case 5: return thursday
        case 6: return friday
        case 7: return saturday
        default: fatalError("invalid")
        }
    }
}

extension Shop.OpeningHours {
    struct Time: Model {
        let start: String
        let end: String
    }
}

extension Shop.OpeningHours.Time: CustomStringConvertible {
    var description: String { "\(start)~\(end)" }
}

// MARK: - Mock
#if DEBUG
extension Shop {
    static var mockList: [Shop] {
        do {
            let data = try Data(resource: R.file.shopListJson)
            return try decoder.decode([Shop].self, from: data)
        } catch {
            print(error)
            return []
        }
    }
}
#endif
