//
//  EventDetailView.swift
//  Feature
//
//  Created by 김은찬 on 12/1/25.
//

import SwiftUI
import FlowKit
import Component
import Kingfisher
import Shimmer

struct EventDetailView: View {
    @ObservedObject var viewModel: EventViewModel
    @Flow var flow
    var body: some View {
        ScrollView {
            if let data = viewModel.detailEvent {
                VStack {
                    if let url = URL(string: data.eventImage) {
                        KFImage(url)
                            .placeholder { _ in
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.gray.opacity(0.3))
                                    .frame(maxWidth: .infinity, maxHeight: 80)
                                    .shimmering()
                            }
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: .infinity, maxHeight: 80)
                            .clipped()
                            .clipShape(size: 8)
                        
                        VStack(alignment: .leading, spacing: 12) {
                            Text(data.title)
                                .font(.title2(.bold))
                                .foreground(LegacyColor.Common.white)
                            
                            Text("\(data.startAt) ~ \(data.endAt)")
                                .font(.caption1(.regular))
                                .foreground(LegacyColor.Label.alternative)
                            
                            Text(data.description)
                                .font(.body1(.regular))
                        }
                        .padding(.top, 20)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .padding(.horizontal, 18)
            } else {
                LegacyLoadingView()
            }
        }
        .backButton(title: "이벤트 상세 정보") {
            flow.pop()
        }
    }
}
