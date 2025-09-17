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
        VStack(alignment: .leading, spacing: 14) {
            Text("프로필 이미지")
                .font(.headline(.bold))
                .foreground(LegacyColor.Common.white)
            
            HStack {
                ZStack(alignment: .bottomTrailing) {
                    if let data = viewModel.userInfo?.imageUrl {
                        KFImage(URL(string: data))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 200, height: 200)
                            .clipShape(size: 16)
                            .clipped()
                    } else {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 200, height: 200)
                            .redacted(reason: .placeholder)
                            .shimmering()
                    }
                    
                    AnimationButton {
                        
                    } label: {
                        Text("이미지 변경")
                            .frame(width: 100, height: 30)
                            .font(.caption2(.bold))
                            .foreground(LegacyColor.Purple.normal)
                            .background(LegacyColor.Fill.normal)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(lineWidth: 1)
                                    .foreground(LegacyColor.Purple.normal)
                            )
                            .padding(6)
                    }
                }
                
                Spacer()
            }
            .padding(.vertical, 8)
            
            Text("자기소개")
                .font(.headline(.bold))
                .foreground(LegacyColor.Common.white)
            
            VStack {
                Text("안녕하세요 팀 레거시입니다")
                    .font(.body2(.bold))
                    .foreground(LegacyColor.Common.white)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 14)
            .padding(.horizontal, 12)
            .background(LegacyColor.Fill.normal)
            .clipShape(size: 12)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 14)
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
                            .inset(by: 0.5)
                            .stroke(lineWidth: 1)
                            .foreground(LegacyColor.Status.positive)
                    )
            }
            .padding(.horizontal, 12)
            .padding(.bottom, 8)
        }
        .backButton(title: "프로필 수정") {
            flow.pop()
        }
    }
}
