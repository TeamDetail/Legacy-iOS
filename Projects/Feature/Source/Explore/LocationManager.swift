import Foundation
import GoogleMaps

final class LocationManager: NSObject, ObservableObject {
    private let manager = CLLocationManager()
    private var locationContinuation: CheckedContinuation<CLLocation, Never>?
    
    @Published var location: CLLocation?
    @Published var isLoading = true

    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func requestAndWaitForLocation() async -> CLLocation {
        manager.requestWhenInUseAuthorization()
        
        return await withCheckedContinuation { continuation in
            locationContinuation = continuation
            manager.startUpdatingLocation()
        }
    }
    
    func updateLocation(_ location: CLLocation) {
        self.location = location
        self.isLoading = false
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
        
        locationContinuation?.resume(returning: location)
        locationContinuation = nil
        manager.stopUpdatingLocation()
    }
}

