import SwiftUI
import Domain
import Component

struct QuizView: View {
    @StateObject var viewModel = QuizViewModel()
    @State private var currentIndex = 0
    @State private var selectedIndices: [Int: Int] = [:]
    @State private var showCreditAlert = false
    
    let userId: Int
    let quizId: Int
    let name: String
    let onDismiss: () -> Void
    let onComplete: () -> Void
    let onFailure: (_ wrongNumbers: [Int]) -> Void
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.8).ignoresSafeArea()
            
            VStack {
                Spacer()
                
                if let quizzes = viewModel.quizList, quizzes.indices.contains(currentIndex) {
                    let quiz = quizzes[currentIndex]
                    let selectedIndex = selectedIndices[currentIndex]
                    
                    HStack {
                        Spacer()
                        HStack {
                            ForEach(0..<min(quizzes.count, 3), id: \.self) { index in
                                Circle()
                                    .frame(width: 8, height: 8)
                                    .foreground(index == currentIndex ? LegacyColor.Primary.normal : LegacyColor.Label.normal)
                            }
                        }
                        .padding(.horizontal, 8)
                    }
                    
                    VStack(spacing: 12) {
                        Text("Q\(currentIndex + 1)")
                            .font(.title2(.bold))
                            .foreground(LegacyColor.Common.white)
                        
                        Text(name)
                            .font(.body1(.medium))
                            .foreground(LegacyColor.Label.alternative)
                            .padding(.vertical, 15)
                        
                        Text(quiz.quizProblem)
                            .font(.title3(.bold))
                            .foreground(LegacyColor.Common.white)
                    }
                    .padding(.bottom, 25)
                    
                    VStack{
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
                            QuizButton(title: "나가기", color: LegacyColor.Common.white, strokeColor: LegacyColor.Label.alternative, width: 64) {
                                onDismiss()
                            }
                        } else {
                            QuizButton(title: "뒤로가기", color: LegacyColor.Common.white, strokeColor: LegacyColor.Label.alternative, width: 64) {
                                currentIndex -= 1
                            }
                        }
                        
                        QuizButton(title: "힌트 확인하기", color: LegacyColor.Blue.netural, strokeColor: LegacyColor.Blue.netural, width: 185) {
                            showCreditAlert = true
                        }
                        
                        QuizButton(title: currentIndex + 1 < quizzes.count ? "다음" : "완료", color: LegacyColor.Common.white, strokeColor: LegacyColor.Label.alternative, width: 64) {
                            if currentIndex + 1 < quizzes.count {
                                currentIndex += 1
                            } else {
                                Task {
                                    await viewModel.checkQuiz(quizId, selectedIndices: selectedIndices)
                                    await MainActor.run {
                                        if viewModel.clearQuiz {
                                            onComplete()
                                        } else {
                                            onFailure(viewModel.wrongNumbers)
                                        }
                                    }
                                }
                            }
                        }
                        .disabled(selectedIndex == nil)
                    }
                } else {
                    LegacyLoadingView(description: "퀴즈 로딩중...")
                }
                
                Spacer()
                Spacer()
                Spacer()
            }
            .padding(.horizontal, 12)
            .task {
                await viewModel.reset(userId)
                await viewModel.fetchQuiz(quizId)
            }
        }
        .alert("크레딧이 필요해요", isPresented: $showCreditAlert) {
            Button("확인") {}
        } message: {
            Text("현재 크레딧: 0")
        }
    }
}
