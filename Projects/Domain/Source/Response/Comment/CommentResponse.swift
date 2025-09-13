//
//  CommentResponse.swift
//  Domain
//
//  Created by 김은찬 on 9/7/25.
//

import Foundation

public struct CommentResponse: ResponseProtocol {
    public let userName: String
    public let userImgUrl: String
    public let rating: Double
    public let comment: String
    public let createAt: String
    
    public init(userName: String, userImgUrl: String, rating: Double, comment: String, createAt: String) {
        self.userName = userName
        self.userImgUrl = userImgUrl
        self.rating = rating
        self.comment = comment
        self.createAt = createAt
    }
}
