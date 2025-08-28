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
    let onLocationButtonTap: (() -> Void)?
    
    func makeCoordinator() -> Coordinator {
        Coordinator(
            isZoomValid: $isZoomValid,
            onBoundsChange: onBoundsChange,
            onPolygonTap: onPolygonTap,
            onMapTap: onMapTap,
            onLocationButtonTap: onLocationButtonTap
        )
    }
    
    func makeUIView(context: Context) -> GMSMapView {
        let defaultLat = 37.5665
        let defaultLng = 126.9780
        let latitude = userLocation?.coordinate.latitude ?? defaultLat
        let longitude = userLocation?.coordinate.longitude ?? defaultLng
        
        let camera = GMSCameraPosition(latitude: latitude, longitude: longitude, zoom: 15)
        let mapOptions = GMSMapViewOptions()
        mapOptions.camera = camera
        mapOptions.mapID = GMSMapID(identifier: mapId)
        
        let mapView = GMSMapView(options: mapOptions)
        mapView.setMinZoom(10, maxZoom: 20)
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = false
        
        context.coordinator.mapView = mapView
        mapView.delegate = context.coordinator
        context.coordinator.setupNotificationObserver()
        
        return mapView
    }
    
    func updateUIView(_ mapView: GMSMapView, context: Context) {
        guard let userLocation else { return }
        
        if !context.coordinator.hasMovedToUserLocation {
            let coord = userLocation.coordinate
            let camera = GMSCameraPosition.camera(withLatitude: coord.latitude, longitude: coord.longitude, zoom: 17)
            mapView.animate(to: camera)
            context.coordinator.hasMovedToUserLocation = true
        }
        
        // MARK: 성능 개선을 위해 clear + bulk polygon 처리
        DispatchQueue.global(qos: .userInitiated).async {
            let myBlockList = (self.myBlocks ?? []).map {
                MapBlock(latitude: $0.latitude, longitude: $0.longitude, type: .myBlock($0.blockType.rawValue))
            }
            
            let ruinsList = (self.ruins ?? []).map { ruin in
                let isOverlapping = self.myBlocks?.contains(where: {
                    self.isSameLocation($0.latitude, $0.longitude, ruin.latitude, ruin.longitude)
                }) ?? false
                return MapBlock(latitude: ruin.latitude, longitude: ruin.longitude, type: .ruins(ruin.ruinsId, isOverlapped: isOverlapping))
            }
            
            let blocks = myBlockList + ruinsList
            
            DispatchQueue.main.async {
                mapView.clear()
                for block in blocks {
                    let rect = makeRectangle(from: LatLng(lat: block.latitude, lng: block.longitude))
                    let path = GMSMutablePath()
                    rect.points.forEach { point in
                        path.add(CLLocationCoordinate2D(latitude: point.lat, longitude: point.lng))
                    }
                    let polygon = GMSPolygon(path: path)
                    polygon.strokeWidth = 1.5
                    polygon.strokeColor = block.type.strokeColor
                    polygon.fillColor = block.type.fillColor
                    polygon.isTappable = block.type.isTappable
                    polygon.userData = block.type.userData
                    polygon.map = mapView
                }
                context.coordinator.userLocation = userLocation
            }
        }
    }
    
    // MARK: - 좌표 근사 비교 함수
    private func isSameLocation(_ lat1: Double, _ lng1: Double, _ lat2: Double, _ lng2: Double) -> Bool {
        let threshold = 0.0001
        return abs(lat1 - lat2) < threshold && abs(lng1 - lng2) < threshold
    }
    
    // MARK: - Coordinator
    class Coordinator: NSObject, GMSMapViewDelegate {
        var mapView: GMSMapView?
        var userLocation: CLLocation?
        let onBoundsChange: (_ bounds: GMSCoordinateBounds) -> Void
        @Binding var isZoomValid: Bool
        var hasMovedToUserLocation = false
        let onPolygonTap: (Int) -> Void
        let onMapTap: (() -> Void)?
        let onLocationButtonTap: (() -> Void)?
        
        init(
            isZoomValid: Binding<Bool>,
            onBoundsChange: @escaping (_ bounds: GMSCoordinateBounds) -> Void,
            onPolygonTap: @escaping (Int) -> Void,
            onMapTap: (() -> Void)? = nil,
            onLocationButtonTap: (() -> Void)? = nil
        ) {
            self._isZoomValid = isZoomValid
            self.onBoundsChange = onBoundsChange
            self.onPolygonTap = onPolygonTap
            self.onMapTap = onMapTap
            self.onLocationButtonTap = onLocationButtonTap
        }
        
        deinit { NotificationCenter.default.removeObserver(self) }
        
        func setupNotificationObserver() {
            NotificationCenter.default.addObserver(
                self,
                selector: #selector(handleMoveToUserLocation),
                name: NSNotification.Name("MoveToUserLocation"),
                object: nil
            )
        }
        
        @objc func handleMoveToUserLocation(notification: Notification) {
            guard let location = notification.object as? CLLocation else { return }
            DispatchQueue.main.async { [weak self] in
                self?.moveToUserLocation(location: location)
            }
        }
        
        func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
            let bounds = GMSCoordinateBounds(region: mapView.projection.visibleRegion())
            isZoomValid = position.zoom <= 10
            onBoundsChange(bounds)
        }
        
        func mapView(_ mapView: GMSMapView, didTap overlay: GMSOverlay) {
            if let polygon = overlay as? GMSPolygon, let ruinsId = polygon.userData as? Int {
                onPolygonTap(ruinsId)
            }
        }
        
        func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
            onMapTap?()
        }
        
        func moveToUserLocation(location: CLLocation? = nil) {
            guard let mapView = mapView else { return }
            let locationToUse = location ?? userLocation
            guard let coord = locationToUse?.coordinate else { return }
            let camera = GMSCameraPosition.camera(withLatitude: coord.latitude, longitude: coord.longitude, zoom: 17)
            mapView.animate(to: camera)
        }
    }
}
