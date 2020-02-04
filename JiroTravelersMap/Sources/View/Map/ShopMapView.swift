import SwiftUI
import Combine
import MapKit

struct ShopMapView: UIViewRepresentable {
    var shopList: [Shop]

    @ObservedObject private var lm = LocationManager()

    func makeUIView(context: UIViewRepresentableContext<ShopMapView>) -> MKMapView {
        let view = MKMapView(frame: .zero)
        view.delegate = context.coordinator
        return view
    }

    func updateUIView(_ mapView: MKMapView, context: UIViewRepresentableContext<ShopMapView>) {
        mapView.showsUserLocation = true

        mapView.removeAnnotations(mapView.annotations)

        let annotations = shopList.map(ShopAnnotation.init)
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

extension ShopMapView {
    class Coordinator: NSObject {
    }
}

extension ShopMapView.Coordinator: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation else { return }
        print(annotation)
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotation = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "annotation")
        annotation.canShowCallout = true
        return annotation
    }
}

#if DEBUG
struct ShopMapView_Previews: PreviewProvider {
    static var previews: some View {
        ShopMapView(shopList: Shop.mockList)
    }
}
#endif
