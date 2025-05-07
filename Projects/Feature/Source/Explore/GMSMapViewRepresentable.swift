import SwiftUI
import GoogleMaps

struct GMSMapViewRepresentable: UIViewRepresentable {
    let userLocation: CLLocation?
    
    func makeUIView(context: Context) -> GMSMapView {
        let mapView = GMSMapView()
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        return mapView
    }
    
    func updateUIView(_ mapView: GMSMapView, context: Context) {
        guard let userLocation else { return }

        let camera = GMSCameraPosition.camera(
            withLatitude: userLocation.coordinate.latitude,
            longitude: userLocation.coordinate.longitude,
            zoom: 15
        )
        mapView.animate(to: camera)
    }

    static func dismantleUIView(_ uiView: GMSMapView, coordinator: ()) {
        uiView.delegate = nil
        uiView.removeFromSuperview()
    }
}
