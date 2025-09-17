//
//  RuinsSearchModal.swift
//  Feature
//
//  Created by 김은찬 on 9/13/25.
//

import SwiftUI
import Component
import Domain

struct RuinsSearchModal: View {
    @ObservedObject var viewModel: ExploreViewModel
    @State private var searchText = ""
    let close: () -> Void
    let clickEvent: (RuinsDetailResponse) -> Void
    
    var body: some View {
        VStack {
            HStack {
                Text("유적지 검색")
                    .font(.heading2(.bold))
                    .foreground(LegacyColor.Common.white)
                
                Spacer()
                
                AnimationButton {
                    close()
                } label: {
                    Image(icon: .close)
                        .foreground(LegacyColor.Common.white)
                }
            }
            .padding(.vertical, 12)
            
            SearchField("유적지 이름으로 검색해주세요.", searchText: $searchText) {
                Task {
                    await viewModel.searchRuins(searchText)
                }
            }
            
            ScrollView(.vertical, showsIndicators: false) {
                if viewModel.isLoadingSearch {
                    LegacyLoadingView("")
                } else if let data = viewModel.searchResult {
                    ForEach(data, id: \.ruinsId) { ruinsData in
                        RuinsSearchResultItem(data: ruinsData) {
                            clickEvent(ruinsData)
                        }
                    }
                    .padding(.vertical, 4)
                }
            }
            
            Spacer()
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 8)
        .frame(width: 320, height: 360)
        .background(LegacyColor.Background.netural)
        .clipShape(size: 20)
    }
}
