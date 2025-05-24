import Foundation
import KakaoSDKUser

class SessionManager: ObservableObject {
    func kakaoLogin() {
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk { oauthToken, error in
                if let error = error {
                    print("카카오톡 로그인 실패: \(error.localizedDescription)")
                } else {
                    print("엑세스: \(oauthToken?.accessToken ?? "")")
                    print("리프래쉬: \(oauthToken?.refreshToken ?? "")")
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
