import Foundation

struct RecordForm {
    var shop: Shop
    var date: Date = .init()
    var size: Size = .small
}

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
