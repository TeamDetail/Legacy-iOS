import SwiftUI
import Domain
import Component

struct QuizView: View {
    @StateObject var viewModel = QuizViewModel()
    @State private var currentIndex = 0
    @State private var selectedIndices: [Int: Int] = [:]
    
    let userId: Int
    let quizId: Int
    let name: String
    let onDismiss: () -> Void
    let onComplete: () -> Void
    let onFailure: (_ wrongNumbers: [Int]) -> Void
    
    var body: some View {
        LegacyModalView {
            VStack {
                Color.clear
                    .frame(height: 30)
                
                if let quizzes = viewModel.quizList {
                    if quizzes.isEmpty {
                        QuizNotExist {
                            onDismiss()
                        }
                    } else if quizzes.indices.contains(currentIndex) {
                        VStack {
                            let quiz = quizzes[currentIndex]
                            let selectedIndex = selectedIndices[currentIndex]
                            
                            ProgressIndicator(totalCount: quizzes.count, currentIndex: currentIndex) //MARK: Progress
                            
                            VStack(spacing: 20) {
                                Text("Q\(currentIndex + 1)")
                                    .font(.title2(.bold))
                                    .foreground(LegacyColor.Common.white)
                                
                                Text(name)
                                    .font(.body1(.medium))
                                    .foreground(LegacyColor.Label.alternative)
                                
                                Text(quiz.quizProblem)
                                    .font(.title3(.bold))
                                    .foreground(LegacyColor.Common.white)
                                    .multilineTextAlignment(.center)
                            }
                            
                            VStack {
                                ForEach(quiz.optionValue.indices, id: \.self) { idx in
                                    QuizProblem(
                                        isSelected: selectedIndex == idx,
                                        description: quiz.optionValue[idx]
                                    ) {
                                        selectedIndices[currentIndex] = idx
                                    }
                                }
                                .padding(.vertical, 4)
                            }
                            .padding(.vertical, 25)
                            
                            HStack(spacing: 8) {
                                if currentIndex == 0 {
                                    QuizButton(title: "나가기", buttonType: .small) {
                                        onDismiss()
                                    }
                                } else {
                                    QuizButton(title: "뒤로가기", buttonType: .small) {
                                        currentIndex -= 1
                                    }
                                }
                                
                                QuizButton(title: "힌트 확인하기", buttonType: .medium) {
                                    //TODO: 구현
                                }
                                
                                QuizButton(
                                    title: currentIndex + 1 < quizzes.count ? "다음" : "완료",
                                    buttonType: .small
                                ) {
                                    if currentIndex + 1 < quizzes.count {
                                        currentIndex += 1
                                    } else {
                                        Task {
                                            await viewModel.checkQuiz(quizId, selectedIndices: selectedIndices)
                                            if viewModel.clearQuiz {
                                                onComplete()
                                            } else {
                                                onFailure(viewModel.wrongNumbers)
                                            }
                                        }
                                    }
                                }
                                .disabled(selectedIndex == nil)
                            }
                        }
                        Spacer()
                    }
                } else {
                    LegacyLoadingView(description: "퀴즈 로딩중...")
                }
            }
            .padding(.horizontal, 16)
        }
        .task {
            await viewModel.reset(userId)
            await viewModel.fetchQuiz(quizId)
        }
    }
}
