//
//  CommentResponse.swift
//  Domain
//
//  Created by 김은찬 on 9/7/25.
//

import Foundation

public struct CommentResponse: ResponseProtocol {
    public let rating: Double
    public let comment: String
    
    public init(rating: Double, comment: String) {
        self.rating = rating
        self.comment = comment
    }
}
