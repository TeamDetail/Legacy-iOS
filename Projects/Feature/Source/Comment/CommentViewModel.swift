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
    @Published var rating: Double = 0.0
    @Published var commentText: String = ""
    
    @Inject var exploreRepository: any ExploreRepository
    
    //MARK: 유적지 평점
    @MainActor
    func createComment(_ ruinsId: Int) async {
        do {
            try await exploreRepository.createComment(
                .init(
                    ruinsId: ruinsId,
                    rating: rating,
                    comment: commentText
                )
            )
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
