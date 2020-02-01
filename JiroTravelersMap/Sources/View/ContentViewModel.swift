import Foundation
import Combine

class ContentViewModel: ObservableObject {
    @Published var shopList: [Shop] = []

    private var cancellables: Set<AnyCancellable> = []

    private let shopRepository: ShopRepository = MixInShopRepository()

    func fetch() {
        shopRepository.fetchShopList()
            .replaceError(with: [])
            .receive(on: RunLoop.main)
            .assign(to: \.shopList, on: self)
            .store(in: &cancellables)
    }
}

#if DEBUG
final class MockContentViewModel: ContentViewModel {
    override init() {
        super.init()
        shopList = Shop.mockList
    }

    override func fetch() {
        // no-op
    }
}
#endif
