//
//  EditInfoView.swift
//  Feature
//
//  Created by 김은찬 on 9/16/25.
//

import Domain
import SwiftUI
import FlowKit
import Shimmer
import Component
import Kingfisher

struct EditInfoView: View {
    @ObservedObject var viewModel: UserViewModel
    @Flow var flow
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("프로필 이미지")
                .font(.headline(.bold))
                .foreground(LegacyColor.Common.white)
            
            HStack {
                if let data = viewModel.userInfo?.imageUrl {
                    KFImage(URL(string: data))
                        .resizable()
                        .frame(width: 200, height: 200)
                        .aspectRatio(contentMode: .fill)
                        .clipShape(size: 16)
                } else {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 200, height: 200)
                        .redacted(reason: .placeholder)
                        .shimmering()
                }
                
                Spacer()
                
                AnimationButton {
                } label: {
                    Text("이미지 변경")
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
            }
            
            Text("자기소개")
                .font(.headline(.bold))
                .foreground(LegacyColor.Common.white)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 10)
        .overlay(alignment: .bottom) {
            AnimationButton {
            } label: {
                Text("변경사항 저장")
                    .frame(maxWidth: .infinity)
                    .frame(height: 45)
                    .font(.caption1(.bold))
                    .foreground(LegacyColor.Status.positive)
                    .background(LegacyColor.Fill.normal)
                    .clipShape(size: 12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .inset(by: 5)
                            .stroke(lineWidth: 1)
                            .foreground(LegacyColor.Status.positive)
                    )
            }
            .padding(.horizontal, 4)
            .padding(.bottom, 8)
        }
        .backButton(title: "프로필 수정") {
            flow.pop()
        }
    }
}
