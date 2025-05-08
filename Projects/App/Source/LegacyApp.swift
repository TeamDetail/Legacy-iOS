import SwiftUI
import Feature
import Legacy_DesignSystem

@main
struct LegacyApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    init() {
        Pretendard.register()
    }
    
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}
