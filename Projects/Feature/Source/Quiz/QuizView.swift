import SwiftUI
import Domain
import Component

struct QuizView: View {
    @State private var hint = "흰트 확인하기"
    @ObservedObject var quizViewModel: QuizViewModel
    @ObservedObject var stateViewModel: QuizStateViewModel
    
    let quizId: Int
    let name: String
    
    var body: some View {
        LegacyModalView {
            VStack {
                Color.clear
                    .frame(height: 40)
                if let quizzes = quizViewModel.quizList {
                    if quizzes.isEmpty {
                        QuizNotExist {
                            stateViewModel.dismissQuiz()
                        }
                    } else {
                        VStack {
                            ProgressIndicator(
                                totalCount: quizzes.count,
                                currentIndex: stateViewModel.currentIndex
                            )
                            
                            if quizzes.indices.contains(stateViewModel.currentIndex) {
                                let quiz = quizzes[stateViewModel.currentIndex]
                                let selectedIndex = stateViewModel.getCurrentSelectedIndex()
                                
                                //MARK: 문제
                                VStack(spacing: 20) {
                                    Text("Q\(stateViewModel.currentIndex + 1)")
                                        .font(.title2(.bold))
                                        .foreground(LegacyColor.Common.white)
                                    
                                    Text(name)
                                        .font(.body1(.medium))
                                        .foreground(LegacyColor.Label.alternative)
                                        .multilineTextAlignment(.center)
                                        .lineLimit(2)
                                    
                                    Text(quiz.quizProblem)
                                        .font(.heading1(.bold))
                                        .foreground(LegacyColor.Common.white)
                                        .multilineTextAlignment(.center)
                                        .padding(.horizontal, 8)
                                        .fixedSize(horizontal: false, vertical: true)
                                }
                                
                                //MARK: 문제목록
                                VStack {
                                    ForEach(quiz.optionValue.indices, id: \.self) { idx in
                                        QuizProblem(
                                            isSelected: selectedIndex == idx,
                                            description: quiz.optionValue[idx]
                                        ) {
                                            stateViewModel.selectOption(at: idx)
                                        }
                                    }
                                    .padding(.vertical, 4)
                                }
                                .padding(.vertical, 25)
                                
                                HStack(spacing: 8) {
                                    QuizButton(
                                        title: stateViewModel.currentIndex == 0 ? "나가기" : "뒤로가기",
                                        buttonType: .small
                                    ) {
                                        if stateViewModel.currentIndex == 0 {
                                            Task {
                                                stateViewModel.dismissQuiz()
                                            }
                                        } else {
                                            stateViewModel.previousQuestion()
                                        }
                                    }
                                    
                                    //MARK: Hint
                                    QuizButton(
                                        title: hint,
                                        buttonType: .medium
                                    ) {
                                        Task {
                                            await quizViewModel.fetchHint(quizId)
                                            hint = "힌트: \(quizViewModel.quizHint)"
                                        }
                                    }
                                    
                                    QuizButton(
                                        title: stateViewModel.isLastQuestion(totalQuestions: quizzes.count) ? "완료" : "다음",
                                        buttonType: .small
                                    ) {
                                        if stateViewModel.isLastQuestion(totalQuestions: quizzes.count) {
                                            Task {
                                                await quizViewModel.checkQuiz(stateViewModel.getAllSelectedAnswers(from: quizzes), stateViewModel: stateViewModel)
                                            }
                                        } else {
                                            withAnimation(.easeInOut(duration: 0.2)) {
                                                stateViewModel.nextQuestion(totalQuestions: quizzes.count)
                                            }
                                        }
                                    }
                                    .disabled(!stateViewModel.hasSelectedOption())
                                    .animation(.easeInOut(duration: 0.15), value: stateViewModel.hasSelectedOption())
                                }
                                .padding(.bottom, 30)
                            }
                        }
                        Spacer()
                    }
                }
                
                if quizViewModel.isLoadingQuiz {
                    LegacyLoadingView("퀴즈를 불러오는 중...")
                }
            }
            .padding(.horizontal, 16)
            .background(LegacyColor.Background.normal)
        }
    }
}
