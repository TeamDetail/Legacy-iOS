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
    public let titleId: Int
    public let styleId: Int
    
    public init(name: String, content: String, titleId: Int, styleId: Int) {
        self.name = name
        self.content = content
        self.titleId = titleId
        self.styleId = styleId
    }
}
