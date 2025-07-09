//
//  RecordItemEnum.swift
//  Component
//
//  Created by 김은찬 on 7/9/25.
//

import Foundation

public enum RecordItemEnum: String {
    case maxScore
    case allBlocks
    case ruinsBlocks
    //TODO: 사용한 크레딧 구현
    
    var title: String {
        switch self {
        case .maxScore:
            "시련 최고 점수"
        case .allBlocks:
            "탐험한 일반 블록 수"
        case .ruinsBlocks:
            "탐험한 유적지 블록 수"
        }
    }
    
    var description: String {
        switch self {
        case .maxScore:
            "문명 점수"
        case .allBlocks:
            "블록"
        case .ruinsBlocks:
            "블록"
        }
    }
}
