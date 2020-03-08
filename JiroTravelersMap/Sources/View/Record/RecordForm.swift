import Foundation

struct RecordForm {
    var shop: Shop
    var date: Date = .init()
    var noodleType: NoodleType = .ramen
    var size: Size = .small
    var veges: Topping = .normal
    var garlic: Topping = .none
    var oil: Topping = .normal
    var taste: Taste = .normal
    var comment: String = ""
}

// MARK: -
extension RecordForm {
    enum NoodleType: CaseIterable {
        case ramen
        case soupless
        case tsukemen
    }
}

extension RecordForm.NoodleType {
    var label: String {
        switch self {
        case .ramen:
            return R.string.noodleType.ramen()
        case .soupless:
            return R.string.noodleType.soupless()
        case .tsukemen:
            return R.string.noodleType.tsukemen()
        }
    }
}

// MARK: -
extension RecordForm {
    enum Size: CaseIterable {
        case mini
        case small
        case large
    }
}

extension RecordForm.Size {
    var label: String {
        switch self {
        case .mini:
            return R.string.size.mini()
        case .small:
            return R.string.size.small()
        case .large:
            return R.string.size.large()
        }
    }
}

// MARK: -
extension RecordForm {
    enum Topping: CaseIterable {
        case none
        case normal
        case more
        case double
    }
}

extension RecordForm.Topping {
    var label: String {
        switch self {
        case .none:
            return "無し"
        case .normal:
            return "普通"
        case .more:
            return "マシ"
        case .double:
            return "マシマシ"
        }
    }
}

// MARK: -
extension RecordForm {
    enum Taste: CaseIterable {
        case light
        case normal
        case heavy
        case double
    }
}

extension RecordForm.Taste {
    var label: String {
        switch self {
        case .light:
            return "薄め"
        case .normal:
            return "普通"
        case .heavy:
            return "カラメ"
        case .double:
            return "カラカラ"
        }
    }
}
