import Foundation

final class SharedState: ObservableObject {
    @Published var showMenu = false
    @Published var displayOnlyOpeningShops = false
    @Published var shopSortOrder: Shop.SortOrder = .id
    @Published var location: Location?
}
