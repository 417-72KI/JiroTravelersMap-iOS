import SwiftUI
import Combine
import MapKit

struct MapView: UIViewRepresentable {
    var annotations: [MKAnnotation]

    private let lm = LocationManager()

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

        mapView.showAnnotations(annotations, animated: true)
    }

    func makeCoordinator() -> Coordinator {
        let coordinator = Coordinator()

        return coordinator
    }
}

extension MapView {
    class Coordinator: NSObject {
    }
}

extension MapView.Coordinator: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "annotation") ?? {
            let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "annotation")
            annotationView.canShowCallout = true
            annotationView.rightCalloutAccessoryView = UIButton(type: .infoLight)
            return annotationView
            }()
        return annotationView
    }

    func mapView(_ mapView: MKMapView,
                 annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        guard case view.rightCalloutAccessoryView = control,
            let annotation = view.annotation as? ShopAnnotation else { return }
        print(annotation)
    }
}

#if DEBUG
struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(annotations: Shop.mockList.map(ShopAnnotation.init))
    }
}
#endif
