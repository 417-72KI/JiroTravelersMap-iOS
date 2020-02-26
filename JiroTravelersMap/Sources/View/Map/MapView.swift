import SwiftUI
import Combine
import MapKit

struct MapView: UIViewRepresentable {
    var annotations: [MKAnnotation]
    @Binding var selectedAnnotation: MKAnnotation?
    var infoAction: ((MKAnnotation) -> Void)?

    init(annotations: [MKAnnotation],
         selectedAnnotation: Binding<MKAnnotation?>,
         infoAction: ((MKAnnotation) -> Void)? = nil) {
        self.annotations = annotations
        _selectedAnnotation = selectedAnnotation
        self.infoAction = infoAction
    }

    private let lm = LocationManager()

    func makeUIView(context: UIViewRepresentableContext<MapView>) -> MKMapView {
        let view = MKMapView(frame: .zero)
        view.delegate = context.coordinator
        return view
    }

    func updateUIView(_ mapView: MKMapView, context: UIViewRepresentableContext<MapView>) {
        mapView.delegate = context.coordinator

        mapView.showsUserLocation = true

        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotations(annotations)

        mapView.showAnnotations(annotations, animated: true)
    }

    func makeCoordinator() -> Coordinator {
        .init(selectedAnnotation: $selectedAnnotation,
              infoAction: infoAction)
    }
}

// MARK: - Coordinator
extension MapView {
    class Coordinator: NSObject {
        @Binding var selectedAnnotation: MKAnnotation?
        private var infoAction: ((MKAnnotation) -> Void)?

        init(selectedAnnotation: Binding<MKAnnotation?>,
             infoAction: ((MKAnnotation) -> Void)?) {
            _selectedAnnotation = selectedAnnotation
            self.infoAction = infoAction
        }
    }
}

// MARK: - MKMapViewDelegate
extension MapView.Coordinator: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation.isEqual(mapView.userLocation) {
            return nil
        }

        let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "annotation") ?? {
            let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "annotation")
            annotationView.canShowCallout = true
            if let _ = infoAction {
                annotationView.rightCalloutAccessoryView = UIButton(type: .infoLight)
            } else {
                annotationView.rightCalloutAccessoryView = nil
            }
            return annotationView
            }()
        return annotationView
    }

    func mapView(_ mapView: MKMapView,
                 annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        guard case view.rightCalloutAccessoryView = control,
            let annotation = view.annotation else { return }
        infoAction?(annotation)
    }

    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        if let selectedAnnotation = selectedAnnotation {
            mapView.selectAnnotation(selectedAnnotation, animated: true)
        }
    }

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        // guard let annotation = view.annotation as? ShopAnnotation else { return }
        // selectedAnnotation = annotation
    }

    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        // selectedAnnotation = nil
    }
}

#if DEBUG
struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(annotations: Shop.mockList.map(ShopAnnotation.init),
                selectedAnnotation: .constant(nil),
                infoAction: nil)
    }
}
#endif
