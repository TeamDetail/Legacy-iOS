import Moya
import Domain

public struct AuthDataSource: DataSourceProtocol {
    public typealias Target = AuthService
    
    public init() {}
    
    public func postLogin(_ request: AuthRequest) async throws -> TokenResponse {
        let response: BaseResponse<TokenResponse> = try await self.request(target: .postLogin(request))
        return response.data
    }
    
    public func postReissue(_ request: RefreshRequest) async throws -> TokenResponse {
        let response: BaseResponse<TokenResponse> = try await self.request(target: .postReissue(request))
        return response.data
    }
}
