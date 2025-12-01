//
//  EventView.swift
//  Feature
//
//  Created by 김은찬 on 12/1/25.
//

import SwiftUI
import FlowKit
import Component

struct EventView: View {
    @StateObject private var viewModel = EventViewModel()
    @Flow var flow
    var body: some View {
        ScrollView {
            if let data = viewModel.event {
                ForEach(data, id: \.self) { data in
                    EventItem(data) {
                        Task {
                            await viewModel.fetchEventDetail(data.eventId)
                            flow.push(EventDetailView(viewModel: viewModel))
                        }
                    }
                    .padding(.horizontal, 14)
                }
            } else {
                LegacyLoadingView()
            }
        }
        .backButton(title: "이벤트") {
            flow.pop()
        }
        .task {
            await viewModel.fetchEvent()
        }
        .refreshable {
            await viewModel.fetchEvent()
        }
    }
}

#Preview {
    EventView()
}
