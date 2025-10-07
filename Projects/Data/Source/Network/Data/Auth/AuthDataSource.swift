import Moya
import Domain

public struct AuthDataSource: DataSourceProtocol {
    public typealias Target = AuthService
    
    public init() {}
    
    public func kakaoLogin(_ request: AuthRequest) async throws -> TokenResponse {
        try await performRequest(.kakaoLogin(request))
    }
    
    public func postReissue(_ request: RefreshRequest) async throws -> TokenResponse {
        try await performRequest(.postReissue(request))
    }
    
    public func appleLogin(_ request: AppleLoginRequest) async throws -> TokenResponse {
        try await performRequest(.appleLogin(request))
    }
    
    public func googleLogin(_ request: GoogleLoginRequest) async throws -> TokenResponse {
        try await performRequest(.googleLogin(request))
    }
}
