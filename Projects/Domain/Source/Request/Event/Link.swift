//
//  Link.swift
//  Domain
//
//  Created by 김은찬 on 12/1/25.
//

import Foundation

public struct Link: Codable {
    public let name: String
    public let link: String
    
    public init(name: String, link: String) {
        self.name = name
        self.link = link
    }
}
