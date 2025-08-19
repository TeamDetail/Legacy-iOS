////
////  Interceptar.swift
////  Data
////
////  Created by 김은찬 on 5/29/25.
////
//
//import Foundation
//import DIContainer
//import Alamofire
//import Domain
//
//final class RemoteInterceptor: RequestInterceptor, @unchecked Sendable  {
//    static let shared = RemoteInterceptor()
//
//    private init() {}
//
//    private var isRefreshing = false
//    private var requestsToRetry: [(RetryResult) -> Void] = []
//
//    private let notReissuePaths = [
//        "/auth/refresh", "/kakao/accessToken"
//    ]
//
//    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, any Error>) -> Void) {
//        var request = urlRequest
//
//        if notReissuePaths.contains(where: { request.url?.absoluteString.contains($0) == true }) {
//            completion(.success(request))
//            return
//        }
//
//        if let token = Sign.accessToken {
//            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
//        }
//        completion(.success(request))
//    }
//
//    func retry(_ request: Request, for session: Session, dueTo error: any Error, completion: @escaping (RetryResult) -> Void) {
//        guard let response = request.response, response.statusCode == 401 else {
//            completion(.doNotRetryWithError(error))
//            return
//        }
//
//        guard let refreshToken = Sign.refreshToken else {
//            completion(.doNotRetryWithError(error))
//            return
//        }
//
//        requestsToRetry.append(completion)
//
//        guard !isRefreshing else { return }
//
//        isRefreshing = true
//
//        Task {
//            @Inject var authRepository: any AuthRepository
//
//            do {
//                print("재발급 하기전\(refreshToken)")
//                try await authRepository.postReissue(
//                    .init(refreshToken: refreshToken)
//                )
//                isRefreshing = false
//                requestsToRetry.forEach { $0(.retry) }
//                requestsToRetry.removeAll()
//            } catch {
//                isRefreshing = false
//                Sign.logout()
//                requestsToRetry.forEach { $0(.doNotRetryWithError(error)) }
//                requestsToRetry.removeAll()
//            }
//        }
//    }
//}

//
//  RemoteInterceptor.swift
//  Data
//
//  Created by 김은찬 on 5/29/25.
//

import Foundation
import DIContainer
import Alamofire
import Domain

final class RemoteInterceptor: RequestInterceptor, @unchecked Sendable {
    static let shared = RemoteInterceptor()
    
    private init() {}
    
    // 성능 최적화: actor로 스레드 안전성 확보하면서 빠른 접근
    private actor RefreshState {
        var isRefreshing = false
        var requestsToRetry: [(RetryResult) -> Void] = []
        
        func addRequest(_ completion: @escaping (RetryResult) -> Void) {
            requestsToRetry.append(completion)
        }
        
        func startRefreshing() -> Bool {
            if isRefreshing { return false }
            isRefreshing = true
            return true
        }
        
        func finishRefreshing(success: Bool, error: Error?) {
            isRefreshing = false
            let result: RetryResult = success ? .retry : .doNotRetryWithError(error ?? URLError(.unknown))
            requestsToRetry.forEach { $0(result) }
            requestsToRetry.removeAll()
        }
    }
    
    private let refreshState = RefreshState()
    
    // 성능 최적화: Set으로 O(1) 검색
    private let notReissuePaths: Set<String> = ["/auth/refresh", "/kakao/accessToken"]
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, any Error>) -> Void) {
        var request = urlRequest
        
        // 성능 최적화: 빠른 경로 체크
        if let path = request.url?.path, notReissuePaths.contains(path) {
            completion(.success(request))
            return
        }
        
        // 성능 최적화: 토큰이 있을 때만 헤더 설정
        if let token = Sign.accessToken, !token.isEmpty {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        completion(.success(request))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: any Error, completion: @escaping (RetryResult) -> Void) {
        // 성능 최적화: 빠른 조건 체크
        guard request.response?.statusCode == 401,
              let refreshToken = Sign.refreshToken, !refreshToken.isEmpty else {
            completion(.doNotRetryWithError(error))
            return
        }
        
        // 성능 최적화: 백그라운드에서 즉시 실행
        Task.detached { [refreshState] in
            await refreshState.addRequest(completion)
            
            // 이미 갱신 중이면 대기열에만 추가
            guard await refreshState.startRefreshing() else { return }
            
            @Inject var authRepository: any AuthRepository
            
            do {
                try await authRepository.postReissue(.init(refreshToken: refreshToken))
                await refreshState.finishRefreshing(success: true, error: nil)
            } catch {
                Sign.logout()
                await refreshState.finishRefreshing(success: false, error: error)
            }
        }
    }
}
