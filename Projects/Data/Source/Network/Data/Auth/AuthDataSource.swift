import Moya
import Domain

public struct AuthDataSource: DataSourceProtocol {
    public typealias Target = AuthService
    
    public let provider: MoyaProvider<AuthService>
    
    public init(provider: MoyaProvider<AuthService> = MoyaProvider<AuthService>()) {
        self.provider = provider
    }
    
    public func postLogin(_ request: AuthRequest) async throws -> TokenResponse {
        let response: BaseResponse<TokenResponse> = try await self.request(target: .postLogin(request))
        return response.data
    }
}
