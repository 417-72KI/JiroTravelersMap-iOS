import SwiftUI
import Combine
import MapKit

struct ShopMapView: View {
    var shopList: [Shop]
    @State private var selectedAnnotation: MKAnnotation?
    @State private var showInfo: Bool = false

    var body: some View {
        MapView(annotations: shopList.map(ShopAnnotation.init),
                selectedAnnotation: $selectedAnnotation,
                showInfo: $showInfo)
    }
}

#if DEBUG
struct ShopMapView_Previews: PreviewProvider {
    static var previews: some View {
        ShopMapView(shopList: Shop.mockList)
    }
}
#endif
