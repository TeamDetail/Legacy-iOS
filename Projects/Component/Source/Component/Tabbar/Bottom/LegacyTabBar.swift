import SwiftUI

public struct LegacyTabBar<Content: View>: View {
    @Binding var selection: LegacyTabItem
    let content: Content
    
    public init(
        selection: Binding<LegacyTabItem>,
        @ViewBuilder content: () -> Content)
    {
        self._selection = selection
        self.content = content()
    }
    
    public var body: some View {
        ScrollViewReader { scrollViewProxy in
            ZStack(alignment: .bottom) {
                content
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea(edges: .bottom)
                
                RoundedRectangle(cornerRadius: 20)
                    .foreground(LegacyColor.Background.normal)
                    .frame(height: 72)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 10)
                    .overlay {
                        VStack {
                            HStack(spacing: 35) {
                                ForEach(LegacyTabItem.allCases, id: \.self) { item in
                                    LegacyNavigationCell(item: item, isSelected: item == selection) {
                                        if selection == item {
                                            withAnimation(.easeInOut(duration: 0.6)) {
                                                scrollViewProxy.scrollTo(
                                                    "ScrollToTop-\(item.rawValue)",
                                                    anchor: .top
                                                )
                                            }
                                        } else {
                                            selection = item
                                        }
                                    }
                                    
                                }
                            }
                        }
                    }
                    .ignoresSafeArea(edges: .bottom)
                    .safeAreaInset(edge: .bottom) {
                        Color.clear.frame(height: 20)
                    }
            }
            .ignoresSafeArea(.all, edges: .bottom)
        }
    }
}
