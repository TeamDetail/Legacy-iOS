//
//  EventRepository.swift
//  Data
//
//  Created by 김은찬 on 12/1/25.
//

import Foundation
import Domain

public protocol EventRepository {
    func fetchEvent() async throws -> [EventResponse]
    func fetchEventDetail(_ eventId: Int) async throws -> EventDetailResponse
    func createEvent(_ request: EventRequest) async throws
}
