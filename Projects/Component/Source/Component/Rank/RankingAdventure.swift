import SwiftUI
import Shimmer

public struct RankingAdventure: View {
    let rank: Int
    let name: String
    
    public init(rank: Int, name: String) {
        self.rank = rank
        self.name = name
    }
    
    public var body: some View {
        HStack {
            Text("\(rank)")
                .font(.bitFont(size: 28))
                .foreground(LegacyColor.Common.white)
            
            Circle()
                .frame(width: 48, height: 48)
                .redacted(reason: .placeholder)
                .shimmering()
            
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(name)
                        .font(.headline(.bold))
                        .foreground(LegacyColor.Common.white)
                    
                    Text("Lv. 99")
                        .font(.caption2(.bold))
                        .foreground(LegacyColor.Label.alternative)
                }
                
                TitleBadge("팀원들", color: LegacyColor.Yellow.alternative)
                    .padding(.horizontal, 20)
            }
            
            Text("50블록")
                .font(.bitFont(size: 18))
                .foreground(LegacyColor.Primary.normal)
        }
        .padding(.horizontal, 20)
    }
}
