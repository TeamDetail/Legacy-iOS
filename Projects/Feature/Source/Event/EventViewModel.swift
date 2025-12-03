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
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @MainActor
    func fetchEventDetail(_ id: Int) async {
        do {
            detailEvent = try await eventRepository.fetchEventDetail(id)
        } catch {
            print(error.localizedDescription)
        }
    }
}

