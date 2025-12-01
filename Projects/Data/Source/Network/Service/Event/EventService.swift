//
//  EventService.swift
//  Data
//
//  Created by 김은찬 on 12/1/25.
//

import Moya
import Domain
import Component

public enum EventService: ServiceProtocol {
    case fetchEvent
    case fetchEventDetail(_ eventId: Int)
    case createEvent(_ request: EventRequest)
}

extension EventService {
    public var host: String {
        "/events"
    }
    
    public var path: String {
        switch self {
        case .fetchEvent:
            ""
        case let .fetchEventDetail(eventId):
            "/\(eventId)"
        case .createEvent:
            ""
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .fetchEvent: .get
        case .fetchEventDetail: .get
        case .createEvent: .post
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case .fetchEvent:
                .requestPlain
        case .fetchEventDetail:
                .requestPlain
        case let .createEvent(request):
            .requestJSONEncodable(request)
        }
    }
}
