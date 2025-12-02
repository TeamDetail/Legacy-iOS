//
//  AppInfoModal.swift
//  Feature
//
//  Created by 김은찬 on 12/2/25.
//

import SwiftUI
import Component

struct AppInfoModal: View {
    let dismiss: () -> Void
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Text("정보")
                    .font(.heading2(.bold))
                    .foreground(LegacyColor.Common.white)
                
                Spacer()
                
                AnimationButton {
                    dismiss()
                } label: {
                    Image(icon: .close)
                }
            }
            .padding(.vertical, 4)
            
            AnimationButton {
                if let url = URL(string: "https://www.notion.so/2936459d2055806e9920d3d7ec692657") {
                    UIApplication.shared.open(url)
                }
            } label: {
                Text("레거시 이용약관")
                    .frame(maxWidth: .infinity)
                    .frame(height: 40)
                    .font(.caption1(.bold))
                    .foreground(LegacyColor.Purple.normal)
                    .background(LegacyColor.Fill.normal)
                    .clipShape(size: 12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .inset(by: 5)
                            .stroke(lineWidth: 1)
                            .foreground(LegacyColor.Purple.normal)
                    )
            }
            
            AnimationButton {
                if let url = URL(string: "https://www.instagram.com/legacyofdetail") {
                    UIApplication.shared.open(url)
                }
            } label: {
                Text("레거시 인스타그램")
                    .frame(maxWidth: .infinity)
                    .frame(height: 40)
                    .font(.caption1(.bold))
                    .foreground(LegacyColor.Red.netural)
                    .background(LegacyColor.Fill.normal)
                    .clipShape(size: 12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .inset(by: 5)
                            .stroke(lineWidth: 1)
                            .foreground(LegacyColor.Red.netural)
                    )
            }
        }
        .padding(.horizontal, 20)
        .frame(width: 310, height: 180)
        .background(LegacyColor.Background.normal)
        .clipShape(size: 20)
    }
}
