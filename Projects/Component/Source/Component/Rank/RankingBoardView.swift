import SwiftUI
import Shimmer
import Domain
import Kingfisher

public struct RankingBoardView: View {
    let rank: Int
    let data: RankResponse
    
    public init(rank: Int, data: RankResponse) {
        self.rank = rank
        self.data = data
    }
    
    public var body: some View {
        HStack {
            Text("\(rank)")
                .font(.bitFont(size: 28))
                .foreground(LegacyColor.Common.white)
                .frame(width: 40, alignment: .center)
            
            if let url = URL(string: data.imageUrl) {
                KFImage(url)
                    .placeholder { _ in
                        Circle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 45, height: 45)
                            .redacted(reason: .placeholder)
                            .shimmering()
                    }
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 45, height: 45)
                    .clipShape(size: 300)
                    .padding(.leading, 8)
            }
            
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text(data.nickname)
                        .font(.headline(.bold))
                        .foreground(LegacyColor.Common.white)
                    
                    Spacer()
                }
                .padding(.horizontal, 8)
                
                if !data.title.name.isEmpty {
                    TitleBadge(data.title.name, color: LegacyColor.Yellow.alternative)
                        .frame(width: 120, alignment: .leading)
                }
            }
            
            Text("\(data.allBlocks)블록")
                .font(.bitFont(size: 18))
                .foregroundStyle(blockColor(for: data.allBlocks))
        }
        .frame(height: 65)
        .padding(.horizontal, 12)
    }
}
