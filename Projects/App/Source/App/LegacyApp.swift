import SwiftUI
import Feature
import Component
import FlowKit
import KakaoSDKAuth

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
                .onOpenURL { url in
                    if AuthApi.isKakaoTalkLoginUrl(url) {
                        _ = AuthController.handleOpenUrl(url: url)
                    }
                }
        }
    }
}
