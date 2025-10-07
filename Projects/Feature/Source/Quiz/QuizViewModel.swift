import Foundation
import DIContainer
import Domain
import Data
import Alamofire
import Shared

public class QuizViewModel: ObservableObject {
    // MARK: - 퀴즈 데이터
    @Published var quizList: [QuizResponse]?
    @Published var quizResponse: CheckQuizResponse?
    @Published var clearQuiz = false
    @Published var wrongNumbers: [Int] = []
    @Published var isLoadingQuiz = false
    @Published var quizHint: String = "흰트가 없어요!"
    
    @Inject var quizRepository: any QuizRepository
    
    
    // MARK: - 나중에 지울것
    @MainActor
    func reset(_ id: Int) async {
        let parameters = ["userId": id]
        
        AF.request(
            serverUrl + "/quiz/quiz-history/reset/\(id)",
            method: .delete,
            parameters: parameters,
            encoding: JSONEncoding.default
        )
        .response { response in
            print("===== RESPONSE =====")
        }
    }
    
    @MainActor
    func fetchQuiz(_ id: Int) async {
        isLoadingQuiz = true
        do {
            quizList = try await quizRepository.fetchQuiz(id)
        } catch {
            print("❌ Error fetching quiz: \(error)")
        }
        isLoadingQuiz = false
    }
    
    @MainActor
    func checkQuiz(_ checkRequests: [CheckQuizRequest], stateViewModel: QuizStateViewModel) async {
        do {
            let response = try await quizRepository.checkQuiz(checkRequests)
            self.quizResponse = response
            self.clearQuiz = response.blockGiven
            
            var wrongs: [Int] = []
            for (index, result) in response.results.enumerated() {
                if !result.isCorrect {
                    wrongs.append(index)
                }
            }
            self.wrongNumbers = wrongs
            
            if clearQuiz {
                stateViewModel.completeQuiz()
            } else {
                stateViewModel.failQuiz()
            }
        } catch {
            print("❌ Error checking quizzes: \(error)")
        }
    }
    
    @MainActor
    func fetchHint(_ quizId: Int) async {
        do {
            quizHint = try await quizRepository.fetchHint(quizId)
        } catch {
            print(error.localizedDescription)
        }
    }
}
