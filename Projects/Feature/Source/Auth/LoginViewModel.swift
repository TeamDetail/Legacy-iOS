import Foundation
import KakaoSDKUser
import DIContainer
import Data
import Domain

class LoginViewModel: ObservableObject {
    @Published var accessToken: String?
    @Published var refreshToken: String?
    @Published var tokenResponse: TokenResponse?
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
    
    func postLogin(_ request: AuthRequest) async {
        do {
            tokenResponse = try await authRepository.postLogin(request)
        } catch {
            print(error.localizedDescription)
        }
    }
}
