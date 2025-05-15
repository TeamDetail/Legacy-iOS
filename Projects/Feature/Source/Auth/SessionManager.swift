import Foundation
import KakaoSDKUser

class SessionManager: ObservableObject {
    func kakaoLogin() {
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk { oauthToken, error in
                if let error = error {
                    print("카카오톡 로그인 실패: \(error.localizedDescription)")
                } else {
                    print("카카오톡 로그인 성공: \(oauthToken?.accessToken ?? "")")
                }
            }
        } else {
            UserApi.shared.loginWithKakaoAccount { oauthToken, error in
                if let error = error {
                    print("카카오톡 로그인 실패: \(error.localizedDescription)")
                } else {
                    print("카카오톡 로그인 성공: \(oauthToken?.accessToken ?? "")")
                }
            }
        }
    }
}
