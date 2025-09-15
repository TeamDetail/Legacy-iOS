import Foundation
import GoogleMaps

//MARK: 현재 내위치 가져오기
final class LocationManager: NSObject, ObservableObject {
    private let manager = CLLocationManager()
    
    @Published var location: CLLocation?
    @Published var isLoading = true
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.distanceFilter = 50
    }
    
    func startUpdating() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func stopUpdating() {
        manager.stopUpdatingLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            manager.startUpdatingLocation()
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        DispatchQueue.main.async {
            self.location = location
            self.isLoading = false
        }
    }
}


//MARK: 대소고로 위치 지정 Test
//extension LocationManager {
//    func setTestLocation() {
//        self.location = CLLocation(latitude: 35.66184787, longitude: 128.41389286)
//        self.isLoading = false
//    }
//}

// MARK: 테스트용 위치 지정 (실제 내 위치 대신 유적지 좌표)
extension LocationManager {
    func setTestLocation() {
        let testLatitude = 35.6977560127
        let testLongitude = 128.4508735791
        
        self.location = CLLocation(latitude: testLatitude, longitude: testLongitude)
        self.isLoading = false
    }
}
