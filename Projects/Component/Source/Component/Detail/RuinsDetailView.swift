import SwiftUI
import Domain
import Kingfisher
import Shimmer

public struct RuinsDetailView: View {
    public let data: RuinsDetailResponse
    public var onClose: (() -> Void)? = nil
    public let action: () -> Void
    
    public init(
        data: RuinsDetailResponse,
        onClose: (() -> Void)? = nil,
        action: @escaping () -> Void
    ) {
        self.data = data
        self.onClose = onClose
        self.action = action
    }
    
    public var body: some View {
        VStack(spacing: 16) {
            Capsule()
                .frame(width: 40, height: 6)
                .foregroundColor(.gray.opacity(0.3))
                .padding(.top, 8)
            
            HStack(alignment: .top, spacing: 16) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("유적지 탐험")
                        .font(.headline(.bold))
                        .foreground(LegacyColor.Common.white)
                    
                    Text("선택한 블록")
                        .font(.body2(.medium))
                        .foreground(LegacyColor.Label.alternative)
                    
                    Text("#\(data.ruinsId)\n \(data.name)")
                        .font(.headline(.medium))
                        .foreground(LegacyColor.Common.white)
                    
                    Text("유적지 정보")
                        .font(.body2(.medium))
                        .foreground(LegacyColor.Label.alternative)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(data.detailAddress)
                        Text(data.periodName)
                    }
                    .font(.headline(.medium))
                    .foreground(LegacyColor.Common.white)
                }
                
                Spacer()
                
                if let url = URL(string: data.ruinsImage) {
                    ZStack(alignment: .bottomLeading) {
                        KFImage(url)
                            .placeholder { _ in
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color.gray.opacity(0.3))
                                    .frame(width: 140, height: 180)
                                    .redacted(reason: .placeholder)
                                    .shimmering()
                            }
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 140, height: 180)
                            .clipShape(size: 16)
                        
                        
                        Text(data.name)
                            .font(.bitFont(size: 14))
                            .foreground(LegacyColor.Common.white)
                            .padding(6)
                            .clipShape(size: 8)
                            .padding([.leading, .bottom], 8)
                    }
                    .overlay(
                        RuinsCategory(
                            category: data.category
                        )
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                        .padding([.leading, .top], 8),
                        alignment: .topLeading
                    )
                }
            }
            
            Button {
                withAnimation(.spring(duration: 0.2)) {
                    HapticManager.instance.impact(style: .soft)
                    action()
                }
            } label: {
                Text("퀴즈 풀고 탐험하기")
                    .frame(maxWidth: .infinity)
                    .font(.body1(.bold))
                    .foreground(LegacyColor.Blue.netural)
                    .padding(.vertical, 14)
                    .background(LegacyColor.Fill.netural)
                    .clipShape(size: 12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(lineWidth: 2)
                            .foreground(LegacyColor.Blue.netural)
                    )
            }
            .padding(.top, 8)
        }
        .padding(20)
        .background(LegacyColor.Background.normal)
        .clipShape(size: 24)
        .padding(.horizontal, 4)
        .shadow(radius: 10)
    }
}
