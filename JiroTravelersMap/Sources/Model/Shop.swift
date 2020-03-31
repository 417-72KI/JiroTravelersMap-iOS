import Foundation

struct Shop: Model, Identifiable {
    let id: Int
    let kind: Kind
    let name: String
    let status: Status
    let prefecture: Prefecture
    let address: String
    let location: Location
    let regularHoliday: [Day]
    let openingHours: OpeningHours
}

// MARK: -
extension Shop {
    var openingToday: String {
        let today = openingHours.today
        if today.isEmpty { return "休" }
        return today.stringValue()
    }

    var nameWithStatus: String {
        switch status {
        case .closed:
            return "\(name)(閉店)"
        case .beforeOpen:
            return "\(name)(まもなくオープン)"
        default:
            return name
        }
    }
}

// MARK: -
extension Shop {
    func isOpening(on date: Date) -> Bool {
        let dateRange = openingHours.forDate(date)
            .map { $0.dateRange(on: date) }
        if dateRange.isEmpty { return false }
        return dateRange.contains(where: { $0.contains(date) })
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
    enum Status: String, Model {
        case open
        case closed
        case beforeOpen = "before_open"
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

// MARK: -
extension Shop.OpeningHours {
    struct Time: Model {
        let start: String
        let end: String
    }
}

extension Shop.OpeningHours.Time {
    var stringValue: String { "\(start)~\(end)" }
}

private extension Shop.OpeningHours.Time {
    var dateFormatter: DateFormatter {
        DateFormatter().apply {
            $0.dateFormat = "HH:mm"
        }
    }
}

extension Shop.OpeningHours.Time {
    func dateRange(on date: Date) -> Range<Date> {
        startAsDate(on: date)..<endAsDate(on: date)
    }
}

private extension Shop.OpeningHours.Time {
    func startAsDate(on date: Date) -> Date {
        parse(start, date: date)
    }

    func endAsDate(on date: Date) -> Date {
        parse(end, date: date)
    }

    func parse(_ string: String, date: Date) -> Date {
        guard let hour = Int(string.prefix(2)),
            let minute = Int(string.suffix(2)) else { fatalError("Invalid format: \(string)") }
        var comp = calendar.dateComponents([.calendar, .year, .month, .day], from: date)
        comp.hour = hour
        comp.minute = minute
        comp.second = 0
        return comp.date!
    }
}

extension Shop.OpeningHours.Time: CustomStringConvertible {
    var description: String { stringValue }
}

extension Array where Element == Shop.OpeningHours.Time {
    func stringValue(separator: String = "\n") -> String {
        map { $0.description }
            .joined(separator: separator)
    }
}

// MARK: -
extension Shop.OpeningHours {
    var stringValue: String {
        arrayValue.filter { !$1.isEmpty }
            .map { ($0, $1.stringValue(separator: R.string.symbol.separator())) }
            .map { "\($0): \($1)" }
            .joined(separator: "\n")
    }

    var arrayValue: [(String, [Time])] {
        [
            (R.string.day.monday_short(), monday),
            (R.string.day.tuesday_short(), tuesday),
            (R.string.day.wednesday_short(), wednesday),
            (R.string.day.thursday_short(), thursday),
            (R.string.day.friday_short(), friday),
            (R.string.day.saturday_short(), saturday),
            (R.string.day.sunday_short(), sunday),
            (R.string.day.holiday_short(), holiday)
        ]
    }
}

// MARK: -
extension Shop {
    enum SortOrder: CaseIterable {
        case id
        case distance
    }
}

extension Shop.SortOrder {
    var label: String {
        switch self {
        case .id:
            return R.string.sortOrder.shop_id()
        case .distance:
            return R.string.sortOrder.distance()
        }
    }
}

// MARK: -
extension Sequence where Element == Shop {
    func sorted(by order: Element.SortOrder, location: Location?) -> [Element] {
        guard case .distance = order, let location = location else {
            return sorted(by: \.id)
        }
        return sorted { $0.location.distance(from: location) < $1.location.distance(from: location) }
    }

    func prefix(maxLength: UInt) -> [Element] {
        if case .max = maxLength {
            return Array(self)
        }
        return Array(prefix(Int(maxLength)))
    }
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
