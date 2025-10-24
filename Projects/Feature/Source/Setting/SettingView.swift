//
//  SettingView.swift
//  Feature
//
//  Created by 김은찬 on 7/14/25.
//

import SwiftUI
import FlowKit
import Component
import Data

struct SettingView: View {
    @EnvironmentObject var viewModel: UserViewModel
    @Flow var flow
    @State private var showDeleteAlert = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                HStack(spacing: 16) {
                    Text("버전정보")
                        .font(.headline(.medium))
                        .foreground(LegacyColor.Common.white)
                    Spacer()
                    Text("1.0.0")
                        .font(.system(size: 18, weight: .medium))
                        .foreground(LegacyColor.Label.disable)
                }
                .padding(8)
                
                Button {
                    showDeleteAlert = true
                } label: {
                    HStack(spacing: 16) {
                        Text("회원탈퇴")
                            .font(.headline(.medium))
                            .foreground(LegacyColor.Status.negative)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foreground(LegacyColor.Label.disable)
                    }
                    .padding(8)
                }
                .alert("정말 탈퇴하시겠습니까?", isPresented: $showDeleteAlert) {
                    Button("취소", role: .cancel) {}
                    Button("탈퇴", role: .destructive) {
                        Task {
                            await viewModel.deleteUser()
                        }
                        flow.pop()
                        Sign.logout()
                    }
                } message: {
                    Text("계정을 삭제하면 모든 데이터가 영구적으로 삭제되며 복구할 수 없습니다.")
                }
                Spacer()
            }
        }
        .padding(.horizontal, 14)
        .backButton(title: "설정") {
            flow.pop()
        }
    }
}

#Preview {
    SettingView()
}
