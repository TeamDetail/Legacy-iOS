import SwiftUI
import FlexibleKit
import Component

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
                VStack(spacing: 8) {
                    Image(icon: .logo)
                    Text("지역 문화를 쉽게 레거시")
                        .font(.headline(.medium))
                        .foreground(LegacyColor.Common.white)
                }
                
                Spacer().frame(height: 180)
                
                VStack(spacing: 20) {
                    Text("소셜 로그인하고 곧바로 뛰어드세요!")
                        .font(.body2(.bold))
                        .foreground(LegacyColor.Common.white)
                    
                    AnimationButton {
                        sessionManager.kakaoLogin()
                    } label: {
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundStyle(Color(0xFEE500))
                            .frame(width: 300, height: 45)
                            .overlay {
                                HStack {
                                    Image(icon: .talk)
                                    Spacer()
                                    Text("카카오 로그인")
                                        .font(.body2(.bold))
                                        .foreground(LegacyColor.Common.black)
                                    Spacer()
                                }
                                .padding(.horizontal, 20)
                                .frame(width: 300)
                            }
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
