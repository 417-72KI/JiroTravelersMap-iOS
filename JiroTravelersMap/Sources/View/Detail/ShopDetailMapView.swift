import SwiftUI

struct ShopDetailMapView: View {
    var shop: Shop

    var body: some View {
        MapView(annotations: [ShopAnnotation(shop: shop)])
            .selectFirst()
    }
}

#if DEBUG
struct ShopDetailMapView_Previews: PreviewProvider {
    static var previews: some View {
        ShopDetailMapView(shop: Shop.mockList[0])
    }
}
#endif
