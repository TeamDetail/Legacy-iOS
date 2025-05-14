import SwiftUI
import Legacy_DesignSystem
import Shared

struct LankingView: View {
    @State private var selection: ShopEnum = .trial
    var body: some View {
        LegacyScrollView(title: "랭킹", icon: .trophy) {
            HStack {
                CategoryButton(category: "시련", select: selection == ShopEnum.trial) {
                    selection = .trial
                }
                CategoryButton(category: "탐험", select: selection == ShopEnum.adventure) {
                    selection = .adventure
                }
                CategoryButton(category: "숙련", select: selection == ShopEnum.skill) {
                    selection = .skill
                }
                
                Spacer()
                
                LankingCategoryButton(category: "친구", select: selection == ShopEnum.friend) {
                    selection = .friend
                }
                LankingCategoryButton(category: "전체", select: selection == ShopEnum.all) {
                    selection = .all
                }
            }
            .padding(.horizontal, 14)
            
            
            switch selection {
            case .trial:
                VStack {
                    Text("zz")
                }
            case .adventure:
                EmptyView()
            case .skill:
                EmptyView()
            case .friend:
                EmptyView()
            case .all:
                EmptyView()
            }
            
            Spacer()
                .frame(height: 110)
        }
        .padding(.top, 80)
        .background(LegacyColor.Background.alternative)
        .overlay(alignment: .top) {
            LegacyTopBar()
        }
    }
}

#Preview {
    LankingView()
}
