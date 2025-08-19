import Foundation
import KakaoSDKUser
import DIContainer
import Data
import Domain

class LoginViewModel: ObservableObject {
    @Inject var authRepository: any AuthRepository
    
    func kakaoLogin() {
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk { oauthToken, error in
                guard let oauthToken = oauthToken else {
                    print("OAuthToken이 nil입니다.")
                    return
                }
                
                let request = AuthRequest(accessToken: oauthToken.accessToken, refreshToken: oauthToken.refreshToken)
                
                Task {
                    await self.postLogin(request)
                }
            }
        } else {
            //MARK: 웹로그인
            UserApi.shared.loginWithKakaoAccount { oauthToken, error in
                guard let oauthToken = oauthToken else {
                    print("OAuthToken이 nil입니다.")
                    return
                }
                
                let request = AuthRequest(accessToken: oauthToken.accessToken, refreshToken: oauthToken.refreshToken)
                
                Task {
                    await self.postLogin(request)
                }
            }
        }
    }
    
    @MainActor
    func postLogin(_ request: AuthRequest) async {
        do {
            _ = try await authRepository.postLogin(request)
        } catch {
            print(error.localizedDescription)
        }
    }
}
