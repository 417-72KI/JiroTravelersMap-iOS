import Foundation
import Combine
import CoreLocation

final class LocationManager: NSObject, ObservableObject {
    private let locationManager: CLLocationManager = .init()

    @Published var isAuthorized: Bool
    @Published var location: Location?

    override init() {
        isAuthorized = false
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    deinit {
        locationManager.stopUpdatingLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.isAuthorized = status.isAuthorized
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.location = locations.first.flatMap(Location.init)
    }
}

// MARK: -
extension CLAuthorizationStatus {
    var isAuthorized: Bool {
        switch self {
        case .authorizedAlways, .authorizedWhenInUse:
            return true
        default:
            return false
        }
    }
}
