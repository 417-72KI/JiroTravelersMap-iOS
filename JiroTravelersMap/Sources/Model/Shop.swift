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
    struct Time: Model {
        let start: String
        let end: String
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
