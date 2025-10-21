import Domain
import Shared
import SwiftUI
import Component

struct UserTitleView: View {
    @StateObject private var viewModel = UserTitleViewModel()
    @EnvironmentObject private var userViewModel: UserViewModel
    @State private var selectedTitleId: Int? = nil
    
    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Text("보유한 칭호")
                    .font(.label(.bold))
                    .foreground(LegacyColor.Label.alternative)
                Spacer()
            }
            
            if let data = viewModel.titleList {
                if data.isEmpty {
                    Text("칭호가 없어요!")
                        .font(.title2(.bold))
                        .foreground(LegacyColor.Common.white)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                } else {
                    LazyVGrid(columns: columns, spacing: 12) {
                        ForEach(data, id: \.styleId) { item in
                            TitleBox(
                                data: item,
                                isSelected: selectedTitleId == item.styleId,
                                onTap: {
                                    withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                                        if selectedTitleId == item.styleId {
                                            selectedTitleId = nil
                                        } else {
                                            selectedTitleId = item.styleId
                                        }
                                    }
                                },
                                action: {
                                    Task {
                                        await viewModel.applyTitle(item.styleId)
                                        await userViewModel.fetchMyinfo()
                                    }
                                }
                            )
                        }
                    }
                }
            } else {
                LegacyLoadingView()
            }
        }
        .padding(.bottom, 6)
        .task {
            await viewModel.fetchTitle()
        }
    }
}


