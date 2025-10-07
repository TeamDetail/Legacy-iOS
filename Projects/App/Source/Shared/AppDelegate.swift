import UIKit
import GoogleMaps
import KakaoSDKCommon
import KakaoSDKAuth
import Shared
import Firebase
import FirebaseMessaging
import UserNotifications
import GoogleSignIn

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        // MARK: Kakao
        KakaoSDK.initSDK(appKey: kakaoKey)
        
        // MARK: Google Maps
        GMSServices.provideAPIKey(mapApiKey)
        
        // MARK: Firebase
        FirebaseApp.configure()
        
        // MARK: 알림 권한 요청
        UNUserNotificationCenter.current().delegate = self
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions
        ) { granted, error in
            print("알림 권한 허용: \(granted)")
            if let error = error {
                print("알림 권한 오류: \(error)")
            }
        }
        
        // APNS 등록
        application.registerForRemoteNotifications()
        
        // Firebase Messaging delegate 설정
        Messaging.messaging().delegate = self
        
        return true
    }
    
    // MARK: - Google 로그인 URL 처리
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if GIDSignIn.sharedInstance.handle(url) {
            return true
        }
        if AuthApi.isKakaoTalkLoginUrl(url) {
            return AuthController.handleOpenUrl(url: url)
        }
        return false
    }
}

// MARK: - UNUserNotificationCenterDelegate
extension AppDelegate: UNUserNotificationCenterDelegate {
    
    // APNS 토큰 등록 성공
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("APNS token: \(deviceToken)")
        Messaging.messaging().apnsToken = deviceToken
    }
    
    // APNS 등록 실패
    func application(_ application: UIApplication,
                     didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register for remote notifications: \(error)")
    }
    
    // Foreground 알림 처리
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.list, .banner, .sound, .badge])
    }
    
    // 알림 탭 처리
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        print("알림 탭됨: \(userInfo)")
        // TODO: 필요시 특정 화면으로 이동 처리
        completionHandler()
    }
}

// MARK: - MessagingDelegate
extension AppDelegate: MessagingDelegate {
    
    // FCM 토큰 받기
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        guard let token = fcmToken else { return }
        print("Firebase registration token: \(token)")
        UserDefaults.standard.set(token, forKey: "FCMToken")
        NotificationCenter.default.post(name: Notification.Name("FCMToken"),
                                        object: nil,
                                        userInfo: ["token": token])
    }
}
