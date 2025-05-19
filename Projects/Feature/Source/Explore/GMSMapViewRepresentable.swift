import SwiftUI
import GoogleMaps
import CoreLocation
import Component

struct GMSMapViewRepresentable: UIViewRepresentable {
    let userLocation: CLLocation?
    
    func makeUIView(context: Context) -> GMSMapView {
        let mapView = GMSMapView()
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        context.coordinator.mapView = mapView
        return mapView
    }
    
    func updateUIView(_ mapView: GMSMapView, context: Context) {
        guard let userLocation else { return }
        
        let coord = userLocation.coordinate
        
        // 중복된 위치인지 확인하고 아니면 사각형 추가
        if !context.coordinator.drawnCoords.contains(where: { $0.isNear(coord, threshold: 0.00005) }) {
            context.coordinator.drawSquare(at: coord)
            context.coordinator.drawnCoords.append(coord)
        }
        
        let camera = GMSCameraPosition.camera(
            withLatitude: coord.latitude,
            longitude: coord.longitude,
            zoom: 17
        )
        mapView.animate(to: camera)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Coordinator {
        var mapView: GMSMapView?
        var drawnCoords: [CLLocationCoordinate2D] = []
        
        func drawSquare(at coordinate: CLLocationCoordinate2D) {
            guard let mapView else { return }
            let offset: CLLocationDegrees = 0.0002
            
            let path = GMSMutablePath()
            path.add(CLLocationCoordinate2D(latitude: coordinate.latitude + offset, longitude: coordinate.longitude - offset))
            path.add(CLLocationCoordinate2D(latitude: coordinate.latitude + offset, longitude: coordinate.longitude + offset))
            path.add(CLLocationCoordinate2D(latitude: coordinate.latitude - offset, longitude: coordinate.longitude + offset))
            path.add(CLLocationCoordinate2D(latitude: coordinate.latitude - offset, longitude: coordinate.longitude - offset))
            path.add(CLLocationCoordinate2D(latitude: coordinate.latitude + offset, longitude: coordinate.longitude - offset))
            
            // 사각형의 범위
            let squareBoundingBox = getBoundingBox(for: path)
            
            // 중복 체크: 기존에 그린 사각형과 겹치는지 확인
            if !isOverlappingWithExistingSquares(squareBoundingBox) {
                let polygon = GMSPolygon(path: path)
                polygon.strokeColor = UIColor(LegacyPalette.shared.purpleNetural)
                polygon.fillColor = UIColor(LegacyPalette.shared.purpleNormal)
                polygon.map = mapView
                drawnCoords.append(coordinate)
            }
        }
        
        // 사각형의 경계를 구하는 함수
        func getBoundingBox(for path: GMSMutablePath) -> (CLLocationCoordinate2D, CLLocationCoordinate2D) {
            var minLat = path.coordinate(at: 0).latitude
            var maxLat = path.coordinate(at: 0).latitude
            var minLon = path.coordinate(at: 0).longitude
            var maxLon = path.coordinate(at: 0).longitude
            
            for i in 1..<path.count() {
                let point = path.coordinate(at: i)
                minLat = min(minLat, point.latitude)
                maxLat = max(maxLat, point.latitude)
                minLon = min(minLon, point.longitude)
                maxLon = max(maxLon, point.longitude)
            }
            
            return (CLLocationCoordinate2D(latitude: minLat, longitude: minLon),
                    CLLocationCoordinate2D(latitude: maxLat, longitude: maxLon))
        }
        
        // 기존 사각형과 겹치는지 확인하는 함수
        func isOverlappingWithExistingSquares(_ boundingBox: (CLLocationCoordinate2D, CLLocationCoordinate2D)) -> Bool {
            for existingCoordinate in drawnCoords {
                let path = getPath(for: existingCoordinate)  // 이미 그려진 사각형의 경계
                let existingBoundingBox = getBoundingBox(for: path) // 기존 사각형의 경계
                
                // 겹치는지 확인 (경계값 비교)
                if (existingBoundingBox.0.latitude < boundingBox.1.latitude &&
                    existingBoundingBox.1.latitude > boundingBox.0.latitude &&
                    existingBoundingBox.0.longitude < boundingBox.1.longitude &&
                    existingBoundingBox.1.longitude > boundingBox.0.longitude) {
                    return true // 겹치는 경우
                }
            }
            return false // 겹치지 않는 경우
        }
        
        // 기존 사각형을 위한 경로를 구하는 함수 (기존 좌표에서 사각형 그리기)
        func getPath(for coordinate: CLLocationCoordinate2D) -> GMSMutablePath {
            let offset: CLLocationDegrees = 0.0002
            let path = GMSMutablePath()
            path.add(CLLocationCoordinate2D(latitude: coordinate.latitude + offset, longitude: coordinate.longitude - offset))
            path.add(CLLocationCoordinate2D(latitude: coordinate.latitude + offset, longitude: coordinate.longitude + offset))
            path.add(CLLocationCoordinate2D(latitude: coordinate.latitude - offset, longitude: coordinate.longitude + offset))
            path.add(CLLocationCoordinate2D(latitude: coordinate.latitude - offset, longitude: coordinate.longitude - offset))
            path.add(CLLocationCoordinate2D(latitude: coordinate.latitude + offset, longitude: coordinate.longitude - offset))
            return path
        }
    }
    
    static func dismantleUIView(_ uiView: GMSMapView, coordinator: Coordinator) {
        uiView.delegate = nil
        uiView.removeFromSuperview()
    }
}

// 중복 방지를 위한 확장
extension CLLocationCoordinate2D {
    func isNear(_ other: CLLocationCoordinate2D, threshold: CLLocationDegrees) -> Bool {
        abs(latitude - other.latitude) < threshold && abs(longitude - other.longitude) < threshold
    }
}
