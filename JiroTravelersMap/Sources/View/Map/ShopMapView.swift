import SwiftUI
import Combine
import MapKit

struct ShopMapView: View {
    var shopList: [Shop]

    var body: some View {
        MapView(annotations: shopList.map(ShopAnnotation.init))
    }
}

#if DEBUG
struct ShopMapView_Previews: PreviewProvider {
    static var previews: some View {
        ShopMapView(shopList: Shop.mockList)
    }
}
#endif
