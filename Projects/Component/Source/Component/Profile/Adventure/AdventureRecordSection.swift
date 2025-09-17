//
//  AdventureRecordSection.swift
//  Component
//
//  Created by 김은찬 on 9/17/25.
//

import SwiftUI
import Domain

public struct AdventureRecordSection: View {
    let record: RecordData
    
    public init(record: RecordData) {
        self.record = record
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ForEach(AdventureKey.allCases, id: \.self) { key in
                if let value = mapValue(for: key, record: record.adventure) {
                    UserRecordRow(title: key.rawValue, value: value)
                }
            }
        }
        .padding(14)
        .background(LegacyColor.Fill.normal)
        .clipShape(size: 12)
    }
    
    private func mapValue(for key: AdventureKey, record: AdventureRecord) -> String? {
        switch key {
        case .allBlocks: return "\(record.allBlocks)"
        case .ruinsBlocks: return "\(record.ruinsBlocks)"
        case .solvedQuizzes: return "\(record.solvedQuizzes)"
        case .wrongQuizzes: return "\(record.wrongQuizzes)"
        case .clearCourse: return "\(record.clearCourse)"
        case .makeCourse: return "\(record.makeCourse)"
        case .commentCount: return "\(record.commentCount)"
        }
    }
}
