//
//  EventResponse.swift
//  Domain
//
//  Created by 김은찬 on 12/1/25.
//

import Foundation

public struct EventResponse: ResponseProtocol {
    public let eventId: Int
    public let title: String
    public let shortDescription: String
    public let startAt: String
    public let endAt: String
    public let eventImage: String
    
    public init(eventId: Int, title: String, shortDescription: String, startAt: String, endAt: String, eventImage: String) {
        self.eventId = eventId
        self.title = title
        self.shortDescription = shortDescription
        self.startAt = startAt
        self.endAt = endAt
        self.eventImage = eventImage
    }
}
