//
//  CommentViewModel.swift
//  Feature
//
//  Created by 김은찬 on 9/8/25.
//

import Foundation
import DIContainer
import Domain
import Data

public class CommentViewModel: ObservableObject {
    @Published var ruinComments: [CommentResponse]?
    
    @Inject var exploreRepository: any ExploreRepository
    
    //MARK: 유적지 평점
    @MainActor
    func createComment(_ request: CommentRequest) async {
        do {
            try await exploreRepository.createComment(request)
        } catch {
            print("에러\(error.localizedDescription)")
        }
    }
    
    @MainActor
    func fetchComment(_ ruinsId: Int) async {
        do {
            ruinComments = try await exploreRepository.fetchComment(ruinsId)
        } catch {
            print("에러\(error.localizedDescription)")
        }
    }
}
