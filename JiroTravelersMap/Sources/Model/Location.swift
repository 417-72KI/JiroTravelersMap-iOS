import Foundation
import CoreLocation

struct Location: Model {
    let lat: Double
    let lng: Double
}

extension Location {
    init(_ location: CLLocation) {
        self.init(lat: location.coordinate.latitude, lng: location.coordinate.longitude)
    }
}

extension Location {
    var clLocation: CLLocation { .init(latitude: lat, longitude: lng) }
    var coordinate: CLLocationCoordinate2D { .init(latitude: lat, longitude: lng) }
}

extension Location {
    func distance(from location: Location) -> CLLocationDistance {
        clLocation.distance(from: location.clLocation)
    }
}
