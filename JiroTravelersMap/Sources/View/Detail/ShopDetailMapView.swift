import SwiftUI
import MapKit

struct ShopDetailMapView: View {
    private let shopAnnotation: ShopAnnotation
    @State private var selectedAnnotation: MKAnnotation?
    @State private var showInfo: Bool = false

    init(shop: Shop) {
        self.shopAnnotation = .init(shop: shop)
    }

    var body: some View {
        MapView(annotations: [shopAnnotation],
                selectedAnnotation: $selectedAnnotation,
                showInfo: $showInfo)
            .onAppear { self.selectedAnnotation = self.shopAnnotation }
    }
}

#if DEBUG
struct ShopDetailMapView_Previews: PreviewProvider {
    static var previews: some View {
        ShopDetailMapView(shop: Shop.mockList[0])
    }
}
#endif
