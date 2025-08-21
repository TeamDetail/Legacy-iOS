//
//  ProfileViewModel.swift
//  Feature
//
//  Created by 김은찬 on 6/23/25.
//

import Foundation
import DIContainer
import Domain
import Data

public class UserViewModel: ObservableObject {
    @Published var userInfo: UserInfoResponse?
    @Published var isLoading: Bool = false
    @Inject var userRepository: any UserRepository
    
    public init() {}
    
    @MainActor
    func fetchMyinfo() async {
        guard !isLoading else { return } // 중복 호출 방지
        
        isLoading = true
        do {
            userInfo = try await userRepository.fetchMyinfo()
        } catch {
            print("\(error)에러")
        }
        isLoading = false
    }
    
    @MainActor
    func refreshUserInfo() async {
        await fetchMyinfo()
    }
}
