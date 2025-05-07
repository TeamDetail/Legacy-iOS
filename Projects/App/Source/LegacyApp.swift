import SwiftUI
import Feature
import GoogleMaps
import Legacy_DesignSystem

@main
struct LegacyApp: App {
    init() {
        GMSServices.provideAPIKey(apiKey)
        Pretendard.register()
    }
    
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}
