import SwiftUI
import GoogleMaps
import CoreLocation
import Component

//MARK: 지도 그리는 역할
struct GMSMapViewRepresentable: UIViewRepresentable {
    let userLocation: CLLocation?
    @Binding var isZoomValid: Bool
    let onBoundsChange: (_ bounds: GMSCoordinateBounds) -> Void

    func makeCoordinator() -> Coordinator {
        Coordinator(isZoomValid: $isZoomValid, onBoundsChange: onBoundsChange)
    }

    func makeUIView(context: Context) -> GMSMapView {
        let mapView = GMSMapView()
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true

        context.coordinator.mapView = mapView
        mapView.delegate = context.coordinator

        return mapView
    }

    func updateUIView(_ mapView: GMSMapView, context: Context) {
        guard let userLocation else { return }

        if context.coordinator.hasMovedToUserLocation == false {
            let coord = userLocation.coordinate
            let camera = GMSCameraPosition.camera(
                withLatitude: coord.latitude,
                longitude: coord.longitude,
                zoom: 17
            )
            mapView.animate(to: camera)
            context.coordinator.hasMovedToUserLocation = true
        }
    }

    class Coordinator: NSObject, GMSMapViewDelegate {
        var mapView: GMSMapView?
        let onBoundsChange: (_ bounds: GMSCoordinateBounds) -> Void
        @Binding var isZoomValid: Bool
        var hasMovedToUserLocation = false

        init(
            isZoomValid: Binding<Bool>,
            onBoundsChange: @escaping (_ bounds: GMSCoordinateBounds) -> Void
        ) {
            self._isZoomValid = isZoomValid
            self.onBoundsChange = onBoundsChange
        }

        func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
            let bounds = GMSCoordinateBounds(region: mapView.projection.visibleRegion())
            isZoomValid = position.zoom <= 15.5
            onBoundsChange(bounds)
        }
    }
}
