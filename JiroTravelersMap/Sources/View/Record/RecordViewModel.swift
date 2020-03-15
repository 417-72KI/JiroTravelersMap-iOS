import Foundation

class RecordViewModel: ObservableObject {
    @Published var form: RecordForm
    @Published var shopList: [Shop]
    @Published var options: [RecordForm.Option]

    init(shop: Shop, shopList: [Shop]) {
        form = RecordForm(shop: shop)
        self.shopList = shopList
        self.options = []
    }
}

extension RecordViewModel {
}
