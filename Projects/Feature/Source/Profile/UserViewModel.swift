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
    
    @Inject var userRepository: any UserRepository
    
    @MainActor
    func fetchMyinfo() async {
        do {
            userInfo = try await userRepository.fetchMyinfo()
        } catch {
            print("\(error)에러")
        }
    }
}
