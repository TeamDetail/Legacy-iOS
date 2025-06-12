import SwiftUI
import GoogleMaps
import CoreLocation
import Component

//MARK: 지도 그리는 역할
struct GMSMapViewRepresentable: UIViewRepresentable {
    let userLocation: CLLocation?
    let onBoundsChange: (_ bounds: GMSCoordinateBounds, _ zoom: Float) -> Void
    
    func makeCoordinator() -> Coordinator {
        Coordinator(onBoundsChange: onBoundsChange)
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
        let onBoundsChange: (_ bounds: GMSCoordinateBounds, _ zoom: Float) -> Void
        var hasMovedToUserLocation = false
        
        init(onBoundsChange: @escaping (_ bounds: GMSCoordinateBounds, _ zoom: Float) -> Void) {
            self.onBoundsChange = onBoundsChange
        }
        
        func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
            guard position.zoom > 15.5 else {
                print("줌이 너무 큼")
                return
            }
            
            let bounds = GMSCoordinateBounds(region: mapView.projection.visibleRegion())
            onBoundsChange(bounds, position.zoom)
        }
    }
}

