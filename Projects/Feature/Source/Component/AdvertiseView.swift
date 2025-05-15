//
//  AdvertiseView.swift
//  Feature
//
//  Created by dgsw30 on 5/8/25.
//

import SwiftUI
import Legacy_DesignSystem
import Shared

struct AdvertiseView: View {
    @ObservedObject var viewModel: ShopViewModel
    
    var body: some View {
        VStack(spacing: 6) {
            VStack(alignment: .leading) {
                Text(makeStyledText(count: 3))
                    .foreground(LegacyColor.Common.white)
                    .font(.heading1(.bold))
                
                Text("현재 가격 배율")
                    .font(.caption2(.medium))
                    .foreground(LegacyColor.Label.alternative)
                
                HStack {
                    Text("1.75배")
                        .font(.title2(.bold))
                        .foreground(LegacyColor.Yellow.netural)
                    
                    Text("카드팩은 하루 동안, 구매 시마다 가격이 상승합니다.")
                        .font(.caption2(.medium))
                        .foreground(LegacyColor.Label.alternative)
                }
            }
            
            
            HStack(alignment: .center) {
                Text("초기화까지")
                    .foreground(LegacyColor.Label.netural)
                
                Text("\(formatTime(viewModel.timeRemaining))")
                    .foreground(LegacyColor.Purple.netural)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 30)
            .font(.caption2(.bold))
            .background(LegacyColor.Fill.netural)
            .clipShape(size: 8)
            .padding(.horizontal, 14)
            
        }
        .frame(maxWidth: .infinity)
        .frame(height: 152)
        .background(LegacyColor.Fill.normal)
        .clipShape(size: 20)
        .padding(.horizontal, 14)
        .onAppear {
            viewModel.checkAndResetShop()
        }
    }
}
