import Foundation
import DIContainer
import Domain
import Data
import Alamofire
import Shared

public class QuizViewModel: ObservableObject {
    @Published var quizList: [QuizResponse]?
    @Published var quizResponse: CheckQuizResponse?
    @Published var clearQuiz = false
    @Published var wrongNumbers: [Int] = []
    
    @Inject var quizRepository: any QuizRepository
    
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
        do {
            quizList = try await quizRepository.fetchQuiz(id)
        } catch {
            print(error)
        }
    }
    
    @MainActor
    func checkQuiz(_ quizId: Int, selectedIndices: [Int: Int]) async {
        guard let quizzes = quizList else { return }
        
        var checkRequests: [CheckQuizRequest] = []
        for (questionIndex, selectedOptionIndex) in selectedIndices.sorted(by: { $0.key < $1.key }) {
            guard questionIndex < quizzes.count else { continue }
            let quiz = quizzes[questionIndex]
            let selectedAnswer = quiz.optionValue[selectedOptionIndex]
            checkRequests.append(CheckQuizRequest(quizId: quiz.quizId, answerOption: selectedAnswer))
        }
        
        do {
            let response = try await quizRepository.checkQuiz(checkRequests)
            self.clearQuiz = response.blockGiven
            
            var wrongs: [Int] = []
            for (index, result) in response.results.enumerated() {
                if !result.isCorrect {
                    wrongs.append(index)
                }
            }
            self.wrongNumbers = wrongs
        } catch {
            print("❌ Error checking quizzes: \(error)")
        }
    }
}
