//
//  EventDataSource.swift
//  Data
//
//  Created by 김은찬 on 12/1/25.
//

import Moya
import Domain

public struct EventDataSource: DataSourceProtocol {
    public typealias Target = EventService
    
    public init() {}

    public func fetchEvent() async throws -> [EventResponse] {
        try await performRequest(.fetchEvent)
    }
    
    public func fetchEventDetail(_ eventId: Int) async throws -> EventDetailResponse {
        try await performRequest(.fetchEventDetail(eventId))
        
    }
    
    public func createEvent(_ request: EventRequest) async throws -> EventResponse {
        try await performRequest(.createEvent(request))
    }
}
