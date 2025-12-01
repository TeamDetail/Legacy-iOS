//
//  EventDetailResponse.swift
//  Domain
//
//  Created by 김은찬 on 12/1/25.
//

import Foundation

public struct EventDetailResponse: Codable {
    public let title: String
    public let shortDescription: String
    public let description: String
    public let startAt: String
    public let endAt: String
    public let eventImage: String
    public let links: [Link]
    
    public init(title: String, shortDescription: String, description: String, startAt: String, endAt: String, eventImage: String, links: [Link]) {
        self.title = title
        self.shortDescription = shortDescription
        self.description = description
        self.startAt = startAt
        self.endAt = endAt
        self.eventImage = eventImage
        self.links = links
    }
}
