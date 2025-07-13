//
//  QuizViewModel.swift
//  Feature
//
//  Created by 김은찬 on 7/13/25.
//

import Foundation
import DIContainer
import Domain
import Data

public class QuizViewModel: ObservableObject {
    @Published var quizList: QuizResponse?
    
    @Inject var quizRepository: any QuizRepository

    
    @MainActor
    func fetchQuiz(_ id: Int) async {
        do {
            quizList = try await quizRepository.fetchQuiz(id)
            print("퀴즈 목록 입니다\(quizList)")
        } catch {
            print(error)
        }
    }
}

