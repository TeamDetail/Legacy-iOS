//
//  Interceptar.swift
//  Data
//
//  Created by 김은찬 on 5/29/25.
//

import Foundation
import DIContainer
import Alamofire
import Domain

final class RemoteInterceptor: RequestInterceptor, @unchecked Sendable  {
    static let shared = RemoteInterceptor()
    
    private init() {}
    
    private var isRefreshing = false
    private var requestsToRetry: [(RetryResult) -> Void] = []
    
    private let notReissuePaths = [
        "/auth/refresh", "/kakao/accessToken"
    ]
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, any Error>) -> Void) {
        var request = urlRequest
        
        if notReissuePaths.contains(where: { request.url?.absoluteString.contains($0) == true }) {
            completion(.success(request))
            return
        }
        
        if let token = Sign.accessToken {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        completion(.success(request))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: any Error, completion: @escaping (RetryResult) -> Void) {
        guard let response = request.response, response.statusCode == 401 else {
            completion(.doNotRetryWithError(error))
            return
        }
        
        guard let refreshToken = Sign.refreshToken else {
            completion(.doNotRetryWithError(error))
            return
        }
        
        requestsToRetry.append(completion)
        
        guard !isRefreshing else { return }
        
        isRefreshing = true
        
        Task {
            @Inject var authRepository: any AuthRepository
            
            do {
                print("재발급 하기전\(refreshToken)")
                try await authRepository.postReissue(
                    .init(refreshToken: refreshToken)
                )
                isRefreshing = false
                requestsToRetry.forEach { $0(.retry) }
                requestsToRetry.removeAll()
            } catch {
                isRefreshing = false
                Sign.logout()
                requestsToRetry.forEach { $0(.doNotRetryWithError(error)) }
                requestsToRetry.removeAll()
            }
        }
    }
}
