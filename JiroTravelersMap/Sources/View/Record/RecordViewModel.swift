import Foundation

class RecordViewModel: ObservableObject {
    @Published var form: RecordForm
    @Published var shopList: [Shop]

    init(shop: Shop, shopList: [Shop]) {
        form = RecordForm(shop: shop)
        self.shopList = shopList
    }
}

extension RecordViewModel {
}
