//
//  UserTitleViewModel.swift
//  Feature
//
//  Created by 김은찬 on 10/20/25.
//

import Foundation
import DIContainer
import Domain
import Data

public class UserTitleViewModel: ObservableObject {
    @Published var titleList: [UserTitleResponse]?
    
    @Inject var userRepository: any UserRepository
    
    @MainActor
    func fetchTitle() async {
        do {
            titleList = try await userRepository.fetchTitle()
        } catch {
            print("에러: \(error)")
        }
    }
    
    @MainActor
    func applyTitle(_ styleId: Int) async {
        do {
            try await userRepository.applyTitle(styleId)
        } catch {
            print("에러: \(error)")
        }
    }
}
