import SwiftUI
import FlexibleKit
import Component
import AuthenticationServices

struct LoginView: View {
    @StateObject private var sessionManager = LoginViewModel()
    @State private var showWebView = false
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            Image(icon: .background)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                Spacer()
                VStack(spacing: 14) {
                    Image(icon: .logo)
                    Text("지역 문화 유산을 쉽게, 레거시")
                        .font(.headline(.medium))
                        .foreground(LegacyColor.Common.white)
                }
                
                Spacer().frame(height: 180)
                
                VStack(spacing: 20) {
                    Text("소셜 로그인하고 곧바로 뛰어드세요!")
                        .font(.body2(.bold))
                        .foreground(LegacyColor.Common.white)
                    
                    KaKaoButton() {
                        sessionManager.startKakaoLogin()
                    }
                    
                    GoogleButton() {
                        
                    }
                    
                    AppleButton() {
                        sessionManager.startAppleLogin()
                    }
                }
                
                Spacer()
                
                Button {
                    showWebView = true
                } label: {
                    Text("서비스 약관 · 개인정보처리방침")
                        .font(.label(.medium))
                        .foreground(LegacyColor.Common.gray)
                }
                .padding(.bottom, 30)
            }
        }
        .sheet(isPresented: $showWebView) {
            FlexibleWebView(url: "https://youtube.com")
        }
        .onAppear {
            SoundPlayer.shared.loginSound()
        }
    }
}

#Preview {
    LoginView()
}
