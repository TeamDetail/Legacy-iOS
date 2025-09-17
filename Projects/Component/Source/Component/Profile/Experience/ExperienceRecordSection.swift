//
//  ExperienceRecordSection.swift
//  Component
//
//  Created by 김은찬 on 9/17/25.
//

import SwiftUI
import Domain

public struct ExperienceRecordSection: View {
    let record: RecordData
    
    public init(record: RecordData) {
        self.record = record
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ForEach(ExperienceKey.allCases, id: \.self) { key in
                if let value = mapValue(for: key, record: record.experience) {
                    UserRecordRow(title: key.rawValue, value: value)
                }
            }
        }
        .padding(14)
        .background(LegacyColor.Fill.normal)
        .clipShape(size: 12)
    }
    
    private func mapValue(for key: ExperienceKey, record: ExperienceRecord) -> String? {
        switch key {
        case .adventureAchieve: return "\(record.adventureAchieve)"
        case .experienceAchieve: return "\(record.experienceAchieve)"
        case .hiddenAchieve: return "\(record.hiddenAchieve)"
        case .createdAt:
            return formatDate(record.createdAt)
        case .titleCount: return "\(record.titleCount)"
        case .cardCount: return "\(record.cardCount)"
        case .shiningCardCount: return "\(record.shiningCardCount)"
        }
    }
    
    private func formatDate(_ dateString: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
        
        if let date = inputFormatter.date(from: dateString) {
            let outputFormatter = DateFormatter()
            outputFormatter.locale = Locale(identifier: "ko_KR")
            outputFormatter.dateFormat = "yyyy-MM-dd"
            return outputFormatter.string(from: date)
        } else {
            return dateString
        }
    }
}
