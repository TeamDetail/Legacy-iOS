//
//  EventRepositoryImpl.swift
//  Data
//
//  Created by 김은찬 on 12/1/25.
//

import Foundation
import Domain

public struct EventRepositoryImpl: EventRepository {
    let dataSource: EventDataSource
    
    public init(dataSource: EventDataSource) {
        self.dataSource = dataSource
    }
    
    public func fetchEvent() async throws -> [EventResponse] {
        let data = try await dataSource.fetchEvent()
        return data
    }
    
    public func fetchEventDetail(_ eventId: Int) async throws -> EventDetailResponse {
        let data = try await dataSource.fetchEventDetail(eventId)
        return data
    }
    
    public func createEvent(_ request: EventRequest) async throws {
        _ = try await dataSource.createEvent(request)
    }
}
