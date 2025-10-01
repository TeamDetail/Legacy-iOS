import Foundation
import AuthenticationServices
import KakaoSDKUser
import DIContainer
import Data
import Domain
import UIKit

class LoginViewModel: NSObject, ObservableObject {
    @Inject var authRepository: any AuthRepository
    
    // MARK: - Kakao 로그인
    func startKakaoLogin() {
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk { oauthToken, error in
                guard let oauthToken = oauthToken else {
                    print("OAuthToken이 nil입니다.")
                    return
                }
                
                let request = AuthRequest(
                    accessToken: oauthToken.accessToken,
                    refreshToken: oauthToken.refreshToken
                )
                
                Task {
                    await self.kakaoLogin(request)
                }
            }
        } else {
            //MARK: 웹로그인
            UserApi.shared.loginWithKakaoAccount { oauthToken, error in
                guard let oauthToken = oauthToken else {
                    print("OAuthToken이 nil입니다.")
                    return
                }
                
                let request = AuthRequest(
                    accessToken: oauthToken.accessToken,
                    refreshToken: oauthToken.refreshToken
                )
                
                Task {
                    await self.kakaoLogin(request)
                }
            }
        }
    }
    
    // MARK: - Apple 로그인
    func startAppleLogin() {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }
    
    // MARK: - API Calls
    @MainActor
    func kakaoLogin(_ request: AuthRequest) async {
        do {
            _ = try await authRepository.kakaoLogin(request)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @MainActor
    func appleLogin(_ request: AppleLoginRequest) async {
        do {
            _ = try await authRepository.appleLogin(request)
        } catch {
            print(error.localizedDescription)
        }
    }
}

// **MARK: - ASAuthorizationControllerDelegate*
extension LoginViewModel: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let credential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let identityToken = credential.identityToken,
                  let tokenString = String(data: identityToken, encoding: .utf8) else {
                print("Apple identityToken 변환 실패")
                return
            }
            
            // fullName이 있으면 저장 (처음 로그인 시에만)
            let fullName = [credential.fullName?.givenName, credential.fullName?.familyName]
                .compactMap { $0 }
                .joined(separator: " ")
            
            if !fullName.isEmpty {
                Sign.saveUserName(fullName)
                print("🍎 Apple User Name 저장: \(fullName)")
            }
            
            let savedName = Sign.userName ?? ""
            
            print("🍎 Apple Identity Token: \(tokenString)")
            print("🍏 Apple User Name (saved): \(savedName)")
            
            if savedName.isEmpty {
                print("⚠️ 경고: 저장된 이름이 없습니다. 애플 로그인 연동을 해제하고 다시 시도해주세요.")
            }
            
            let request = AppleLoginRequest(idToken: tokenString, name: savedName)
            
            Task {
                await self.appleLogin(request)
            }
        }
    }
}

// MARK: - ASAuthorizationControllerPresentationContextProviding
extension LoginViewModel: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return UIApplication.shared.connectedScenes
            .compactMap { ($0 as? UIWindowScene)?.keyWindow }
            .first ?? ASPresentationAnchor()
    }
}
