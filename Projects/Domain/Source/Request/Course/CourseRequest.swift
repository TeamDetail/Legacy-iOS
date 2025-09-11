//
//  CourseRequest.swift
//  Domain
//
//  Created by 김은찬 on 9/11/25.
//

import Foundation

public struct CourseRequest: RequestProtocol {
    public let name: String
    public let tag: [String]
    public let description: String
    public let ruinsId: [Int]
    
    public init(name: String, tag: [String], description: String, ruinsId: [Int]) {
        self.name = name
        self.tag = tag
        self.description = description
        self.ruinsId = ruinsId
    }
}
