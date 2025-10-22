//
//  MailView.swift
//  Feature
//
//  Created by 김은찬 on 8/27/25.
//

import SwiftUI
import Component

struct MailView: View {
    @StateObject private var viewModel = MailViewModel()
    @State private var selection = 0
    let onClose: () -> Void
    var body: some View {
        ZStack {
            if let data = viewModel.rewardMails {
                MailRewardsView(data: data) {
                    viewModel.rewardMails = nil
                    selection = 0
                }
            } else {
                VStack(spacing: 14) {
                    HStack {
                        Image(icon: .mail)
                        Text("우편함")
                            .font(.bitFont(size: 28))
                        
                        Spacer()
                        
                        AnimationButton {
                            onClose()
                        } label: {
                            Image(icon: .close)
                        }
                    }
                    .foreground(LegacyColor.Common.white)
                    .padding(.top, 18)
                    .padding(.horizontal, 18)
                    
                    if selection == 0 {
                        if let mails = viewModel.myMail {
                            if mails.isEmpty {
                                VStack {
                                    Spacer()
                                    Text("우편함이 비었어요!")
                                        .font(.headline(.bold))
                                        .foreground(LegacyColor.Common.white)
                                    Spacer()
                                }
                            } else {
                                ScrollView(showsIndicators: false) {
                                    VStack(spacing: 12) {
                                        ForEach(mails, id: \.self) { mailData in
                                            MailboxItem(data: mailData) {
                                                viewModel.selectMail = mailData
                                                selection = 1
                                            }
                                            .padding(.horizontal, 24)
                                        }
                                        .padding(.vertical, 4)
                                    }
                                }
                                .padding(.bottom, 60)
                                .refreshable {
                                    Task { await viewModel.fetchMail() }
                                }
                            }
                        } else {
                            LegacyLoadingView()
                                .frame(maxHeight: .infinity)
                                .padding(.top, 10)
                        }
                    } else {
                        if let data = viewModel.selectMail {
                            MailDetailView(
                                data: data
                            ) {
                                selection = 0
                            }
                        } else {
                            LegacyLoadingView()
                                .padding(.top, 10)
                        }
                    }
                }
                .overlay(alignment: .bottom) {
                    if selection == 0, let mails = viewModel.myMail, !mails.isEmpty {
                        AnimationButton {
                            Task {
                                await viewModel.postAward()
                            }
                        } label: {
                            Text("일괄 수령")
                                .frame(maxWidth: .infinity)
                                .frame(height: 40)
                                .font(.caption1(.bold))
                                .foreground(LegacyColor.Yellow.netural)
                                .background(LegacyColor.Fill.normal)
                                .clipShape(size: 12)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .inset(by: 5)
                                        .stroke(lineWidth: 1)
                                        .foreground(LegacyColor.Yellow.netural)
                                )
                        }
                        .padding(.bottom, 10)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 4)
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: UIScreen.main.bounds.height * 0.60)
                .background(LegacyColor.Background.normal)
                .clipShape(size: 20)
                .padding(16)
                .task {
                    await viewModel.fetchMail()
                }
            }
        }
    }
}
