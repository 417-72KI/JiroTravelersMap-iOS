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
        shopList = mockShopList
    }

    override func fetch() {
        // no-op
    }

    private var mockShopList: [Shop] {
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
