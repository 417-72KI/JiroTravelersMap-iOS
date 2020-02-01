import Foundation
import Combine

protocol ShopRepository {
    func fetchShopList() -> AnyPublisher<[Shop], AppError>
}

struct MixInShopRepository: ShopRepository {
    func fetchShopList() -> AnyPublisher<[Shop], AppError> {
        URLSession.shared
            .dataTaskPublisher(for: "https://jirotravelersmap.web.app/shop_list/origin.json")
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

#if DEBUG
struct MockShopRepository: ShopRepository {
    func fetchShopList() -> AnyPublisher<[Shop], AppError> {
        Just<[Shop]>(shopList)
            .setFailureType(to: AppError.self)
            .eraseToAnyPublisher()
    }

    private var shopList: [Shop] {
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
