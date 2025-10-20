//
//  QuizProblemViewWrapper.swift
//  Feature
//
//  Created by 김은찬 on 10/20/25.
//

import SwiftUI
import Component

struct QuizProblemViewWrapper: View, Equatable {
    let description: String
    let isSelected: Bool
    let onTap: () -> Void
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.isSelected == rhs.isSelected &&
        lhs.description == rhs.description
    }
    
    var body: some View {
        QuizProblem(
            isSelected: isSelected,
            description: description,
            action: onTap
        )
    }
}
