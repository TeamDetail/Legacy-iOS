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
        var urlRequest = urlRequest
        if let accessToken = UserDefaults.standard.string(forKey: "accessToken") {
            urlRequest.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
            print("저장")
        } else {
            print("엑세스 저장 x")
        }
        completion(.success(urlRequest))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: any Error, completion: @escaping (RetryResult) -> Void) {
        guard let response = request.task?.response as? HTTPURLResponse else {
            completion(.doNotRetryWithError(error))
            return
        }
        
        guard response.statusCode == 401,
              let refreshToken = UserDefaults.standard.string(forKey: "refreshToken") else {
            completion(.doNotRetryWithError(error))
            return
        }
        
        @Inject var authRepository: any AuthRepository
        
        Task {
            do {
                try await authRepository.postReissue(
                    .init(
                        refreshToken: refreshToken
                    )
                )
                completion(.retry)
            } catch {
                UserDefaults.standard.removeObject(forKey: "accessToken")
                UserDefaults.standard.removeObject(forKey: "refreshToken")
                print(error.localizedDescription)
                completion(.doNotRetryWithError(error))
            }
        }
    }
}
