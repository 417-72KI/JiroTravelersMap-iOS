import SwiftUI
import Combine
import MapKit

struct ShopMapView: View {
    var shopList: [Shop]
    @State private var selectedAnnotation: MKAnnotation?
    @State private var detailView: AnyView?
    @State private var tag: Int?

    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: detailView, tag: showDetailTag, selection: $tag) {
                    EmptyView()
                }
                MapView(annotations: shopList.map(ShopAnnotation.init),
                        selectedAnnotation: $selectedAnnotation) {
                            guard let annotation = $0 as? ShopAnnotation else { return }
                            self.detailView = AnyView(ShopDetailView(shop: annotation.shop))
                            self.tag = showDetailTag
                }.navigationBarTitle("", displayMode: .inline)
            }
        }
    }
}

private let showDetailTag: Int = 999

#if DEBUG
struct ShopMapView_Previews: PreviewProvider {
    static var previews: some View {
        ShopMapView(shopList: Shop.mockList)
    }
}
#endif
