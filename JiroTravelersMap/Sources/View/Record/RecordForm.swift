import Foundation

struct RecordForm {
    var shop: Shop
    var date: Date = .init()
    var noodleType: NoodleType = .ramen
    var size: Size = .small
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
