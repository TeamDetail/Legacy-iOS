//
//  UserTitleResponse.swift
//  Domain
//
//  Created by 김은찬 on 10/20/25.
//

import Foundation

public struct UserTitleResponse: ResponseProtocol {
    public let name: String
    public let content: String
    public let grade: Int
    public let styleId: Int
    
    public init(name: String, content: String, grade: Int, styleId: Int) {
        self.name = name
        self.content = content
        self.grade = grade
        self.styleId = styleId
    }
}
