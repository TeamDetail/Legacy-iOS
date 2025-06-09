import Moya
import Domain

public enum AuthService: ServiceProtocol {
    case postLogin(_ request: AuthRequest)
    case postReiuse(_ request: RefreshRequest)
}

extension AuthService {
    public var host: String {
        switch self {
        case .postLogin:
            "/kakao/accessToken"
        case .postReiuse:
            "/auth/refresh"
        }
    }
    
    public var path: String {
        switch self {
        case .postLogin: return ""
        case .postReiuse: return ""
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .postLogin: .post
        case .postReiuse: .post
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case let .postLogin(request):
            request.toJSONParameters()
        case let .postReiuse(request):
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
