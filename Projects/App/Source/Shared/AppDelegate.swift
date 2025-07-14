import GoogleMaps
import KakaoSDKCommon
import KakaoSDKAuth
import Shared

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        GMSServices.provideAPIKey(mapApiKey)
        KakaoSDK.initSDK(appKey: kakaoKey)
        return true
    }
}
