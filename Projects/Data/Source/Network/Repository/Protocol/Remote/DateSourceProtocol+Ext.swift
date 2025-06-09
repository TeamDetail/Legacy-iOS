import Moya
import Foundation
import Domain

public extension DataSourceProtocol {
    var provider: MoyaProvider<Target> {
        MoyaProvider<Target>(
            session: Moya.Session(interceptor: RemoteInterceptor()),
            plugins: [NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))]
        )
    }
    
    func request<T: Decodable>(target: Target) async throws -> BaseResponse<T> {
        let response = try await withCheckedThrowingContinuation { continuation in
            provider.request(target) { result in
                switch result {
                case .success(let response):
                    continuation.resume(returning: response)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
        return try JSONDecoder().decode(BaseResponse<T>.self, from: response.data)
    }
}


