import SwiftUI
import Domain
import Component

struct QuizView: View {
    @State private var hint = "힌트 확인하기"
    @State private var isHintLoading = false
    @ObservedObject var quizViewModel: QuizViewModel
    @ObservedObject var stateViewModel: QuizStateViewModel
    
    let quizId: Int
    let name: String
    
    var body: some View {
        LegacyModalView {
            VStack {
                Color.clear.frame(height: 40)
                if let quizzes = quizViewModel.quizList {
                    if quizzes.isEmpty {
                        QuizNotExist { stateViewModel.dismissQuiz() }
                    } else {
                        VStack {
                            ProgressIndicator(
                                totalCount: quizzes.count,
                                currentIndex: stateViewModel.currentIndex
                            )
                            
                            if quizzes.indices.contains(stateViewModel.currentIndex) {
                                let quiz = quizzes[stateViewModel.currentIndex]
                                let selectedIndex = stateViewModel.getCurrentSelectedIndex()
                                
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
                                
                                VStack {
                                    ForEach(quiz.optionValue.indices, id: \.self) { idx in
                                        EquatableView(
                                            content: QuizProblemViewWrapper(
                                                description: quiz.optionValue[idx],
                                                isSelected: selectedIndex == idx
                                            ) {
                                                stateViewModel.selectOption(at: idx)
                                            }
                                        )
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
                                            Task { stateViewModel.dismissQuiz() }
                                        } else {
                                            stateViewModel.previousQuestion()
                                        }
                                    }
                                    
                                    QuizButton(
                                        title: isHintLoading ? "불러오는 중..." : hint,
                                        buttonType: .medium
                                    ) {
                                        Task {
                                            isHintLoading = true
                                            hint = "힌트 불러오는 중..."
                                            
                                            await quizViewModel.fetchHint(quizId)
                                            
                                            withAnimation {
                                                hint = "힌트: \(quizViewModel.quizHint)"
                                                isHintLoading = false
                                            }
                                        }
                                    }
                                    
                                    QuizButton(
                                        title: stateViewModel.isLastQuestion(totalQuestions: quizzes.count) ? "완료" : "다음",
                                        buttonType: .small
                                    ) {
                                        if stateViewModel.isLastQuestion(totalQuestions: quizzes.count) {
                                            Task {
                                                await quizViewModel.checkQuiz(
                                                    stateViewModel.getAllSelectedAnswers(from: quizzes),
                                                    stateViewModel: stateViewModel
                                                )
                                            }
                                        } else {
                                            stateViewModel.nextQuestion(totalQuestions: quizzes.count)
                                        }
                                    }
                                    .disabled(!stateViewModel.hasSelectedOption())
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
