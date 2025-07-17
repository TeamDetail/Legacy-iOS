import SwiftUI
import Domain
import Shared
import Component
import GoogleMaps
import CoreLocation

//MARK: 지도 그리는 역할
struct GMSMapViewRepresentable: UIViewRepresentable {
    let userLocation: CLLocation?
    let ruins: [RuinsPositionResponse]?
    let myBlocks: [CreateBlockResponse]?
    
    @Binding var isZoomValid: Bool
    let onBoundsChange: (_ bounds: GMSCoordinateBounds) -> Void
    let onPolygonTap: (_ ruinsId: Int) -> Void
    let onMapTap: (() -> Void)?
    
    func makeCoordinator() -> Coordinator {
        Coordinator(
            isZoomValid: $isZoomValid,
            onBoundsChange: onBoundsChange,
            onPolygonTap: onPolygonTap,
            onMapTap: onMapTap
        )
    }
    
    func makeUIView(context: Context) -> GMSMapView {
        //MARK: init하기 위한 더미 좌표
        let defaultLat = 37.5665
        let defaultLng = 126.9780
        let latitude = userLocation?.coordinate.latitude ?? defaultLat
        let longitude = userLocation?.coordinate.longitude ?? defaultLng
        
        let camera = GMSCameraPosition(
            latitude: latitude,
            longitude: longitude,
            zoom: 15
        )
        
        let mapOptions = GMSMapViewOptions()
        mapOptions.camera = camera
        mapOptions.mapID = GMSMapID(identifier: mapApiKey)
        
        //MARK: deprecated 메서드 대신 init(options:) 사용
        let mapView = GMSMapView(options: mapOptions)
        
        mapView.setMinZoom(10.0, maxZoom: 20.0)
        
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        
        //MARK: Coordinator 연결
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
        
        //MARK: 유적지 표시
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
        
        //MARK: 내블록 표시
        for block in myBlocks ?? [] {
            let rect = makeRectangle(from: LatLng(lat: block.latitude, lng: block.longitude))
            let path = GMSMutablePath()
            rect.points.forEach { point in
                path.add(CLLocationCoordinate2D(latitude: point.lat, longitude: point.lng))
            }
            
            let polygon = GMSPolygon(path: path)
            polygon.strokeColor = UIColor(LegacyPalette.shared.green40)
            polygon.fillColor = UIColor(LegacyPalette.shared.greenNormal)
            polygon.strokeWidth = 1.5
            polygon.map = mapView
        }
        
    }
    
    class Coordinator: NSObject, GMSMapViewDelegate {
        var mapView: GMSMapView?
        let onBoundsChange: (_ bounds: GMSCoordinateBounds) -> Void
        @Binding var isZoomValid: Bool
        var hasMovedToUserLocation = false
        let onPolygonTap: (Int) -> Void
        let onMapTap: (() -> Void)?
        
        init(
            isZoomValid: Binding<Bool>,
            onBoundsChange: @escaping (_ bounds: GMSCoordinateBounds) -> Void,
            onPolygonTap: @escaping (Int) -> Void,
            onMapTap: (() -> Void)? = nil
        ) {
            self._isZoomValid = isZoomValid
            self.onBoundsChange = onBoundsChange
            self.onPolygonTap = onPolygonTap
            self.onMapTap = onMapTap
        }
        
        func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
            let bounds = GMSCoordinateBounds(region: mapView.projection.visibleRegion())
            isZoomValid = position.zoom <= 10
            onBoundsChange(bounds)
        }
        
        func mapView(_ mapView: GMSMapView, didTap overlay: GMSOverlay) {
            if let polygon = overlay as? GMSPolygon,
               let ruinsId = polygon.userData as? Int {
                onPolygonTap(ruinsId)
            }
        }
        
        func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
            onMapTap?()
        }
    }
}
