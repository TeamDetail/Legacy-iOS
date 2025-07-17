import Moya
import Domain

public enum AuthService: ServiceProtocol {
    case postLogin(_ request: AuthRequest)
    case postReissue(_ request: RefreshRequest)
}

extension AuthService {
    public var host: String {
        switch self {
        case .postLogin:
            "/kakao/accessToken"
        case .postReissue:
            "/auth/refresh"
        }
    }
    
    public var path: String {
        ""
    }
    
    public var method: Moya.Method {
        switch self {
        case .postLogin: .post
        case .postReissue: .post
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case let .postLogin(request):
            request.toJSONParameters()
        case let .postReissue(request):
            request.toJSONParameters()
        }
    }
    
    public var headers: [String: String]? {
        ["Content-Type": "application/json"]
    }
    
    public var validationType: ValidationType {
        .none
    }
}
