import Moya
import Domain

public struct AuthDataSource: DataSourceProtocol {
    public typealias Target = AuthService
    
    public init() {}
    
    public func postLogin(_ request: AuthRequest) async throws -> TokenResponse {
        try await performRequest(.postLogin(request))
    }
    
    public func postReissue(_ request: RefreshRequest) async throws -> TokenResponse {
        try await performRequest(.postReissue(request))
    }
}
