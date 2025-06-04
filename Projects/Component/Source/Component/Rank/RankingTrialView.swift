import SwiftUI

public struct RankingTrialView: View {
    public init(){}
    public var body: some View {
        HStack {
            Text("180")
                .font(.bitFont(size: 28))
                .foreground(LegacyColor.Common.white)
            
            Circle()
                .frame(width: 48, height: 48)
            
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text("박재민")
                        .font(.headline(.bold))
                        .foreground(LegacyColor.Common.white)
                    
                    Text("Lv. 99")
                        .font(.caption2(.bold))
                        .foreground(LegacyColor.Label.alternative)
                }
                
                TitleBadge("자본주의", size: .medium)                    
            }
            
            Text("180층")
                .font(.bitFont(size: 28))
                .foreground(LegacyColor.Yellow.netural)
        }
        .padding(.horizontal, 20)
    }
}
