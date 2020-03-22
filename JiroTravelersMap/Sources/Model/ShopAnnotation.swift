import Foundation
import MapKit

final class ShopAnnotation: NSObject, MKAnnotation {
    let shop: Shop

    init(shop: Shop) {
        self.shop = shop
    }

    var coordinate: CLLocationCoordinate2D { shop.location.coordinate }
    var title: String? { shop.nameWithStatus }
    var subtitle: String? { shop.address }
}
