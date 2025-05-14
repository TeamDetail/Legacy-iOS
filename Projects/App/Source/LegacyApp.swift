import SwiftUI
import Feature
import Legacy_DesignSystem
import FlowKit

@main
struct LegacyApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    init() {
        Pretendard.register()
    }
    
    var body: some Scene {
        WindowGroup {
            FlowPresenter(rootView: RootView())
                .ignoresSafeArea()
        }
    }
}
