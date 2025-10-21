//
//  DailyView.swift
//  Feature
//
//  Created by 김은찬 on 10/20/25.
//

import SwiftUI
import Component
import Domain

struct DailyView: View {
    @StateObject private var viewModel = DailyViewModel()
    @State private var selectedDay: Int = 1
    @State private var selection = 0
    @State private var showingDetail = false
    let close: () -> Void
    
    var body: some View {
        VStack(spacing: 14) {
            HStack {
                Text("출석체크")
                    .font(.heading2(.bold))
                    .foreground(LegacyColor.Common.white)
                Spacer()
                AnimationButton {
                    close()
                } label: {
                    Image(icon: .close)
                        .foreground(LegacyColor.Common.white)
                }
            }
            .padding(.horizontal, 4)
            .padding(.vertical, 4)
            .padding(.top, 14)
            
            if let data = viewModel.myDaily, let dateData = data.first {
                
                HStack {
                    CategoryButtonGroup(
                        categories: [dateData.name],
                        selection: $selection
                    )
                    Spacer()
                }
                
                HStack {
                    Text("기간")
                        .font(.caption1(.medium))
                        .foreground(LegacyColor.Label.alternative)
                    Spacer()
                    Text("\(dateData.startAt) ~ \(dateData.endAt)")
                        .font(.caption1(.medium))
                        .foreground(LegacyColor.Label.alternative)
                }
                .padding(.horizontal, 4)
                
                if selection == 0 {
                    VStack(spacing: 14) {
                        ScrollView(showsIndicators: false) {
                            let columns = Array(repeating: GridItem(.flexible(), spacing: 8), count: 7)
                            
                            LazyVGrid(columns: columns, spacing: 8) {
                                ForEach(1...dateData.awards.count, id: \.self) { day in
                                    let isCompleted = day <= dateData.checkCount
                                    let isSelected = selectedDay == day
                                    
                                    DateButton(
                                        isSelceted: .constant(isSelected),
                                        lastDate: isCompleted,
                                        onSelect: {
                                            guard !isCompleted else { return }
                                            selectedDay = day
                                            showingDetail = true
                                            
                                            viewModel.selectDaily = DailyResponse(
                                                id: dateData.id,
                                                name: dateData.name,
                                                startAt: dateData.startAt,
                                                endAt: dateData.endAt,
                                                awards: [dateData.awards[day - 1]],
                                                checkCount: dateData.checkCount,
                                                check: dateData.check
                                            )
                                        },
                                        date: day
                                    )
                                }
                            }
                        }
                        
                        if showingDetail, let selectedDaily = viewModel.selectDaily {
                            let nextAvailableDay = dateData.checkCount + 1
                            let isTodayChecked = dateData.check
                            let isTodayAvailable = selectedDay == nextAvailableDay
                            let isButtonEnabled = isTodayAvailable && !isTodayChecked
                            
                            let buttonText: String = {
                                if isTodayChecked && isTodayAvailable {
                                    return "오늘 이미 출석했어요!"
                                } else if isTodayAvailable {
                                    return "출석하기"
                                } else {
                                    return "출석 일이 아니에요!"
                                }
                            }()
                            
                            VStack {
                                LegacyDivider()
                                HStack {
                                    Text("\(selectedDay)일차 보상")
                                        .font(.body2(.bold))
                                        .foreground(LegacyColor.Common.white)
                                    Spacer()
                                }
                                .padding(4)
                                
                                ScrollView(showsIndicators: false) {
                                    ForEach(selectedDaily.awards[0], id: \.self) { item in
                                        DailyItem(inventory: item)
                                            .padding(.vertical, 2)
                                    }
                                    .padding(.horizontal, 4)
                                }
                                
                                AnimationButton {
                                    Task {
                                        await viewModel.postAward(selectedDaily.id)
                                        await viewModel.fetchDaily()
                                        showingDetail = false
                                    }
                                } label: {
                                    Text(buttonText)
                                        .font(.caption1(.bold))
                                        .foreground(isButtonEnabled ? LegacyColor.Primary.normal : LegacyColor.Label.alternative)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 40)
                                        .background(LegacyColor.Fill.normal)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 8)
                                                .inset(by: 5)
                                                .stroke(lineWidth: 1)
                                                .foreground(isButtonEnabled ? LegacyColor.Primary.normal : LegacyColor.Label.alternative)
                                        )
                                        .clipShape(size: 8)
                                }
                                .disabled(!isButtonEnabled)
                            }
                        }
                    }
                    Spacer()
                }
            } else {
                LegacyLoadingView()
                Spacer()
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: showingDetail
               ? UIScreen.main.bounds.height * 0.62
               : UIScreen.main.bounds.height * 0.48)
        .animation(.easeInOut, value: showingDetail)
        .padding(.horizontal, 16)
        .background(LegacyColor.Background.netural)
        .clipShape(size: 20)
        .padding(16)
        .task {
            await viewModel.fetchDaily()
            if let data = viewModel.myDaily?.first {
                selectedDay = min(data.checkCount + 1, data.awards.count)
            }
        }
    }
}
