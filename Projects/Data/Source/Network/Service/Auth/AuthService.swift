import Moya
import Domain

public enum AuthService: ServiceProtocol {
    case postLogin(_ request: AuthRequest)
}

extension AuthService {
    public var host: String {
        "/kakao/code"
    }
    
    public var path: String {
        switch self {
        case .postLogin: return ""
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .postLogin: .post
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case let .postLogin(request):
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
