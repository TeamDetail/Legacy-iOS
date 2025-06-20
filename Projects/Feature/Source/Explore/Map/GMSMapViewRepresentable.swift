import SwiftUI
import Domain
import Component
import GoogleMaps
import CoreLocation

//MARK: 지도 그리는 역할
struct GMSMapViewRepresentable: UIViewRepresentable {
    let userLocation: CLLocation?
    let ruins: [RuinsPositionResponse]?
    
    @Binding var isZoomValid: Bool
    let onBoundsChange: (_ bounds: GMSCoordinateBounds) -> Void
    let onPolygonTap: (_ ruinsId: Int) -> Void
    
    func makeCoordinator() -> Coordinator {
        Coordinator(
            isZoomValid: $isZoomValid,
            onBoundsChange: onBoundsChange,
            onPolygonTap: onPolygonTap
        )
        
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
        
        mapView.clear()
        
        for ruin in ruins ?? [] {
            let rect = makeRectangle(from: LatLng(lat: ruin.latitude, lng: ruin.longitude))
            let path = GMSMutablePath()
            rect.points.forEach { point in
                path.add(CLLocationCoordinate2D(latitude: point.lat, longitude: point.lng))
            }
            
            let polygon = GMSPolygon(path: path)
            polygon.strokeColor = UIColor(LegacyPalette.shared.primary)
            polygon.fillColor = UIColor(LegacyPalette.shared.purpleNetural)
            polygon.strokeWidth = 1.5
            polygon.userData = ruin.ruinsId
            polygon.isTappable = true // 탭했을때
            polygon.map = mapView
        }
    }
    
    class Coordinator: NSObject, GMSMapViewDelegate {
        var mapView: GMSMapView?
        let onBoundsChange: (_ bounds: GMSCoordinateBounds) -> Void
        @Binding var isZoomValid: Bool
        var hasMovedToUserLocation = false
        let onPolygonTap: (Int) -> Void
        
        init(
            isZoomValid: Binding<Bool>,
            onBoundsChange: @escaping (_ bounds: GMSCoordinateBounds) -> Void,
            onPolygonTap: @escaping (Int) -> Void
        ) {
            self._isZoomValid = isZoomValid
            self.onBoundsChange = onBoundsChange
            self.onPolygonTap = onPolygonTap
        }
        
        func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
            let bounds = GMSCoordinateBounds(region: mapView.projection.visibleRegion())
            isZoomValid = position.zoom <= 15.5
            onBoundsChange(bounds)
        }
        
        func mapView(_ mapView: GMSMapView, didTap overlay: GMSOverlay) {
            if let polygon = overlay as? GMSPolygon,
               let ruinsId = polygon.userData as? Int {
                print("Polygon tapped: ruinsId = \(ruinsId)")
                onPolygonTap(ruinsId)
            }
        }
    }
}
