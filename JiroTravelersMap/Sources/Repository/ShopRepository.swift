import Foundation
import Combine

protocol ShopRepository {
    func fetchShopList() -> AnyPublisher<[Shop], AppError>
}

struct MixInShopRepository: ShopRepository {
    func fetchShopList() -> AnyPublisher<[Shop], AppError> {
        URLSession.shared
            .dataTaskPublisher(for: shopListRequest)
            .tryMap { data, res -> Data in
                guard let response = res as? HTTPURLResponse else {
                    throw APIError.invalidResponse
                }
                if (200..<300).contains(response.statusCode) == false {
                    throw APIError.invalidResponseStatus(code: response.statusCode)
                }
                return data
            }
        .decode(type: [Shop].self, decoder: decoder)
        .mapError { $0.asAppError() }
        .eraseToAnyPublisher()
    }
}

private extension MixInShopRepository {
    var shopListRequest: URLRequest {
        .init(url: "https://jirotravelersmap.web.app/shop_list/origin.json",
              cachePolicy: .reloadIgnoringCacheData)
    }
}

#if DEBUG
struct MockShopRepository: ShopRepository {
    func fetchShopList() -> AnyPublisher<[Shop], AppError> {
        Just<[Shop]>(Shop.mockList)
            .setFailureType(to: AppError.self)
            .eraseToAnyPublisher()
    }
}
#endif
