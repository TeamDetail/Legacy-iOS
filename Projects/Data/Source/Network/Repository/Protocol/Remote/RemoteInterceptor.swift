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

final class RemoteInterceptor: RequestInterceptor {
    static let shared = RemoteInterceptor()
    
    private init() {}
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, any Error>) -> Void) {
        guard let accessToken = Sign.accessToken else {
            print("❌ [adapt] accessToken 없음")
            completion(.success(urlRequest))
            return
        }
        
        var modifiedRequest = urlRequest
        modifiedRequest.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
        
        print("✅ [adapt] Authorization 헤더 설정: Bearer \(accessToken)")
        completion(.success(modifiedRequest))
    }
    
    
    func retry(_ request: Request, for session: Session, dueTo error: any Error, completion: @escaping (RetryResult) -> Void) {
        guard let response = request.task?.response as? HTTPURLResponse else {
            completion(.doNotRetryWithError(error))
            return
        }
        
        guard request.retryCount <= 3 else {
            print("❌ RemoteInterceptor - RetryCount가 3보다 큽니다")
            completion(.doNotRetry)
            return
        }
        
        if response.statusCode == 200 {
            completion(.doNotRetry)
            return
        }
        
        guard response.statusCode == 401, let refreshToken = Sign.refreshToken else {
            completion(.doNotRetryWithError(error))
            return
        }
        
        @Inject var authRepository: any AuthRepository
        
        Task {
            do {
                try await authRepository.postReissue(.init(refreshToken: refreshToken))
                print("✅ [retry] 재발급 후 accessToken:", Sign.accessToken ?? "없음")
                print("✅ [retry] 재발급 후 refreshToken:", Sign.refreshToken ?? "없음")
                DispatchQueue.main.async {
                    completion(.retry)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.doNotRetryWithError(error))
                    Sign.logout()
                    print("토큰 재발급 실패")
                }
            }
        }
    }
}
