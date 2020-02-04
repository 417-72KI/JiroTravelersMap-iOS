import SwiftUI

struct ShopDetailView: View {
    let shop: Shop

    var body: some View {
        Text(shop.name)
    }
}

#if DEBUG
struct ShopDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ShopDetailView(shop: Shop.mockList[0])
    }
}
#endif
