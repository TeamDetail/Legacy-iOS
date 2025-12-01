//
//  EventViewModel.swift
//  Feature
//
//  Created by 김은찬 on 12/1/25.
//

import Foundation
import DIContainer
import Domain
import Data

class EventViewModel: ObservableObject {
    @Published var event: [EventResponse]?
    @Published var detailEvent: EventDetailResponse?
    @Inject var eventRepository: any EventRepository
    
    @MainActor
    func fetchEvent() async {
        do {
            event = try await eventRepository.fetchEvent()
            event = [EventResponse(eventId: 1, title: "테스트", shortDescription: "안녕", startAt: "2025.01.01", endAt: "2026.01.01", eventImage: "helo")]
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @MainActor
    func fetchEventDetail(_ id: Int) async {
        detailEvent = EventDetailResponse(title: "테스트", shortDescription: "ㅎㅇ", description: "ㅎㅇ", startAt: "2025.01.01", endAt: "2026.01.01", eventImage: "ㄹㅇ나ㅣ", links: [.init(name: "fd", link: "fd")])
        //        do {
        //            detailEvent = try await eventRepository.fetchEventDetail(id)
        //            detailEvent = EventDetailResponse(title: "테스트", shortDescription: "ㅎㅇ", description: "ㅎㅇ", startAt: "2025.01.01", endAt: "2026.01.01", eventImage: "ㄹㅇ나ㅣ", links: [.init(name: "fd", link: "fd")])
        //        } catch {
        //            print(error.localizedDescription)
        //        }
    }
}

