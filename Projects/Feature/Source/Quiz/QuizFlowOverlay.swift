import Domain
import SwiftUI
import Component

struct QuizFlowOverlay: View {
    @ObservedObject var quizViewModel: QuizViewModel
    @ObservedObject var stateViewModel: QuizStateViewModel
    @ObservedObject var userData: UserViewModel
    let ruinDetail: RuinsDetailResponse?
    
    var body: some View {
        ZStack {
            //MARK: 퀴즈 화면
            if stateViewModel.showQuiz, let detail = ruinDetail {
                QuizView(
                    quizViewModel: quizViewModel,
                    stateViewModel: stateViewModel,
                    quizId: detail.ruinsId,
                    name: detail.name
                )
                .zIndex(1000)
            }
            
            //MARK: 성공 애니메이션
            if stateViewModel.showClap {
                ClapView {
                    stateViewModel.showResult()
                }
                .zIndex(1500)
            }
            
            //MARK: 완료 화면
            if stateViewModel.showFinishView, let reward = ruinDetail {
                FinishQuizView(data: reward) {
                    stateViewModel.hideResult()
                }
                .zIndex(2000)
            }
            
            //MARK: 실패 화면
            if stateViewModel.showCrying {
                CryingView(dismiss: {
                    stateViewModel.dismissFailure()
                }, wrongNumbers: quizViewModel.wrongNumbers) {
                    stateViewModel.retryQuiz()
                }
            }
        }
    }
}
