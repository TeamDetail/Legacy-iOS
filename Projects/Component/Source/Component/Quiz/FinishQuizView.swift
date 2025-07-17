//
//  FinishQuizView.swift
//  Component
//
//  Created by 김은찬 on 7/17/25.
//

import Kingfisher
import SwiftUI
import Shimmer
import Domain

public struct FinishQuizView: View {
    public let data: RuinsDetailResponse
    let onDismiss: () -> Void
    
    public init(
        data: RuinsDetailResponse,
        onDismiss: @escaping () -> Void
    ) {
        self.data = data
        self.onDismiss = onDismiss
    }
    
    public var body: some View {
        ZStack {
            Color.black.opacity(0.8)
                .ignoresSafeArea()
                .onTapGesture {
                    onDismiss()
                }
            
            VStack {
                Spacer()
                
                if let url = URL(string: data.ruinsImage) {
                    ZStack(alignment: .init(horizontal: .leading, vertical: .bottom)) {
                        KFImage(url)
                            .placeholder { _ in
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color.gray.opacity(0.3))
                                    .frame(width: 200, height: 280)
                                    .redacted(reason: .placeholder)
                                    .shimmering()
                            }
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 200, height: 280)
                            .clipShape(size: 20)
                        
                        Text(data.name)
                            .font(.bitFont(size: 14))
                            .foreground(LegacyColor.Common.white)
                            .padding(12)
                            .clipShape(size: 20)
                    }
                    .padding(4)
                    .overlay(
                        RuinsCategory(
                            category: data.category
                        )
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                        .padding([.leading, .top], 12),
                        alignment: .topLeading
                    )
                    .padding(.vertical, 8)
                }
                
                Text("카드를 획득했어요!")
                    .font(.title2(.bold))
                    .foreground(LegacyColor.Common.white)
                
                Spacer()
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                onDismiss()
            }
        }
    }
}
