import Moya
import Foundation
import Domain

public extension DataSourceProtocol {
    var provider: MoyaProvider<Target> {
        .init(
            session: Moya.Session(interceptor: RemoteInterceptor.shared),
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
        
        if response.statusCode >= 400 {
            let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: response.data)
            throw errorResponse
        }
        
        return try JSONDecoder().decode(BaseResponse<T>.self, from: response.data)
    }
}
