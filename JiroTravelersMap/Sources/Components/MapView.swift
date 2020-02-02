import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    typealias UIViewType = MKMapView

    @ObservedObject private var lm = LocationManager()
    var annotations: [MKAnnotation]

    func makeUIView(context: UIViewRepresentableContext<MapView>) -> MKMapView {
        let view = MKMapView(frame: .zero)
        view.delegate = context.coordinator
        return view
    }

    func updateUIView(_ mapView: MKMapView, context: UIViewRepresentableContext<MapView>) {
        mapView.showsUserLocation = true

        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotations(annotations)

        if lm.isAuthorized,
            let location = lm.location {
            let span = MKCoordinateSpan(latitudeDelta: 0.009, longitudeDelta: 0.009)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            mapView.setRegion(region, animated: true)
        }
    }

    func makeCoordinator() -> Coordinator { .init() }
}

extension MapView {
    class Coordinator: NSObject {
    }
}

extension MapView.Coordinator: MKMapViewDelegate {
}

#if DEBUG
struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(annotations: [])
    }
}
#endif
