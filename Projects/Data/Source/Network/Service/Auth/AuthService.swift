import Moya
import Domain

public enum AuthService: ServiceProtocol {
    case kakaoLogin(_ request: AuthRequest)
    case postReissue(_ request: RefreshRequest)
    case appleLogin(_ request: AppleLoginRequest)
}

extension AuthService {
    public var host: String {
        switch self {
        case .kakaoLogin:
            "/kakao/accessToken"
        case .postReissue:
            "/auth/refresh"
        case .appleLogin:
            "/apple/accessToken"
        }
    }
    
    public var path: String {
        ""
    }
    
    public var method: Moya.Method {
        switch self {
        case .kakaoLogin: .post
        case .postReissue: .post
        case .appleLogin: .post
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case let .kakaoLogin(request):
            request.toJSONParameters()
        case let .postReissue(request):
            request.toJSONParameters()
        case let .appleLogin(request):
            request .toJSONParameters()
        }
    }
    
    public var headers: [String: String]? {
        ["Content-Type": "application/json"]
    }
    
    public var validationType: ValidationType {
        .none
    }
}
