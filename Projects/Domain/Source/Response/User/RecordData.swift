//
//  RecordData.swift
//  Domain
//
//  Created by 김은찬 on 7/14/25.
//

import Foundation

public struct RecordData: ResponseProtocol {
    public let adventure: AdventureRecord
    public let experience: ExperienceRecord
}
