import Foundation
import Combine

final class SharedState: ObservableObject {
    @Published var showMenu = false
    @Published var displayOnlyOpeningShops = false
    @Published var showLocationError = false
    @Published var shopSortOrder: Shop.SortOrder = .id {
        didSet {
            guard case .distance = shopSortOrder else {
                self.location = nil
                return
            }
            guard let location = locationManager.location else {
                showLocationError = true
                return
            }
            self.location = location
        }
    }
    @Published var location: Location?
    @Published var maxDisplayCount: UInt = .max

    private let locationManager = LocationManager()
    private var cancellables: Set<AnyCancellable> = []
}

extension SharedState {
    static let displayCountCandidates: [UInt] = [5, 10, 20, .max]
}
