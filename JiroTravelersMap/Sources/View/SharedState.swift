import Foundation

final class SharedState: ObservableObject {
    @Published var showMenu = false
    @Published var displayOnlyOpeningShops = false
}
