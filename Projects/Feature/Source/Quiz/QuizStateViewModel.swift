//
//  QuizStateViewModel.swift
//  Feature
//
//  Created by 김은찬 on 7/19/25.
//


import Foundation
import SwiftUI
import Domain

public class QuizStateViewModel: ObservableObject {
    // MARK: - UI 상태 관리
    @Published var showQuiz = false
    @Published var showFinishView = false
    @Published var showClap = false
    @Published var showCrying = false
    @Published var currentIndex = 0
    @Published var selectedIndices: [Int: Int] = [:]
    
    // MARK: - 탭바 숨김 상태 관리
    @Published var shouldHideTabBar = false
    
    // MARK: - Quiz Flow Management
    @MainActor
    func startQuiz() {
        resetQuizState()
        showQuiz = true
        shouldHideTabBar = true
    }
    
    @MainActor
    func dismissQuiz() {
        showQuiz = false
        resetQuizState()
        shouldHideTabBar = false
    }
    
    @MainActor
    func completeQuiz() {
        showQuiz = false
        showClap = true
    }
    
    @MainActor
    func failQuiz() {
        showQuiz = false
        showCrying = true
    }
    
    @MainActor
    func showResult() {
        showClap = false
        showFinishView = true
    }
    
    @MainActor
    func hideResult() {
        showFinishView = false
        shouldHideTabBar = false
    }
    
    @MainActor
    func retryQuiz() {
        showCrying = false
        resetQuizProgress()
        showQuiz = true
        shouldHideTabBar = true
    }
    
    @MainActor
    func dismissFailure() {
        showCrying = false
        resetQuizState()
        shouldHideTabBar = false
    }
    
    // MARK: - Quiz Progress Management
    @MainActor
    func nextQuestion(totalQuestions: Int) {
        guard currentIndex + 1 < totalQuestions else { return }
        currentIndex += 1
    }
    
    @MainActor
    func previousQuestion() {
        guard currentIndex > 0 else { return }
        currentIndex -= 1
    }
    
    @MainActor
    func selectOption(at index: Int) {
        selectedIndices[currentIndex] = index
    }
    
    @MainActor
    func isLastQuestion(totalQuestions: Int) -> Bool {
        return currentIndex + 1 >= totalQuestions
    }
    
    @MainActor
    func hasSelectedOption() -> Bool {
        return selectedIndices[currentIndex] != nil
    }
    
    // MARK: - State Reset
    @MainActor
    private func resetQuizState() {
        showQuiz = false
        showFinishView = false
        showClap = false
        showCrying = false
        resetQuizProgress()
    }
    
    @MainActor
    private func resetQuizProgress() {
        currentIndex = 0
        selectedIndices = [:]
    }
    
    // MARK: - Helper Methods
    func getCurrentSelectedIndex() -> Int? {
        return selectedIndices[currentIndex]
    }
    
    func getAllSelectedAnswers(from quizList: [QuizResponse]) -> [CheckQuizRequest] {
        var checkRequests: [CheckQuizRequest] = []
        for (questionIndex, selectedOptionIndex) in selectedIndices.sorted(by: { $0.key < $1.key }) {
            guard questionIndex < quizList.count else { continue }
            let quiz = quizList[questionIndex]
            let selectedAnswer = quiz.optionValue[selectedOptionIndex]
            checkRequests.append(CheckQuizRequest(quizId: quiz.quizId, answerOption: selectedAnswer))
        }
        return checkRequests
    }
}
