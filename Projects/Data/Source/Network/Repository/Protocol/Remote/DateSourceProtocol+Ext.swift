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
            throw APIError.serverMessage(errorResponse.message)
        }
        
        return try JSONDecoder().decode(BaseResponse<T>.self, from: response.data)
    }
    
    func performRequest<T: Decodable>(_ target: Target) async throws -> T {
        let response: BaseResponse<T> = try await request(target: target)
        //        guard response.status == 200, let data = response.data else {
        //            throw APIError.serverMessage(response.message ?? "알 수 없는 오류")
        //        }
        return response.data
    }
}
