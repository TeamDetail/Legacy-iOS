//
//  ShopView.swift
//  Feature
//
//  Created by dgsw30 on 5/8/25.
//

import SwiftUI
import Component

struct ShopView: View {
    @State private var selection = 0
    @Binding var tabItem: LegacyTabItem
    @StateObject private var viewModel = ShopViewModel()
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    //TODO: 더미값 삭제 할 것
    let dummyPurplePacks = [
        PackModel(id: 0, name: "삼국시대 팩", description: "고구려 & 신라 & 백제 특성\n카드가 포함된 카드팩", credit: 300_000, colorable: LegacyColor.Purple.netural),
        PackModel(id: 1, name: "고려시대 팩", description: "고려의 기상이 담긴 카드들을\n만날 수 있는 카드팩", credit: 300_000, colorable: LegacyColor.Purple.netural),
        PackModel(id: 2, name: "조선시대 팩", description: "조선시대의 아름다움과\n대한제국의 발전을 느낄 수\n있는 카드팩", credit: 300_000, colorable: LegacyColor.Purple.netural),
        PackModel(id: 3, name: "대한민국 팩", description: "자랑스러운 우리 나라,\n대한민국의 문화가 담긴 카드팩", credit: 300_000, colorable: LegacyColor.Purple.netural)
    ]
    
    let dummyRedPacks = [
        PackModel(id: 4, name: "경상도 팩", description: "경상북도 & 경상남도의\n카드가 포함된 카드팩", credit: 300_000, colorable: LegacyColor.Red.netural),
        PackModel(id: 5, name: "경기도 팩", description: "경기도의 카드가\n포함된 카드팩", credit: 300_000, colorable: LegacyColor.Red.netural),
        PackModel(id: 6, name: "충청도 팩", description: "충청북도 & 충청남도의\n카드가 포함된 카드팩", credit: 300_000, colorable: LegacyColor.Red.netural),
        PackModel(id: 7, name: "전라도 팩", description: "전라북도 & 전라남도의\n카드가 포함된 카드팩", credit: 300_000, colorable: LegacyColor.Red.netural),
        PackModel(id: 8, name: "제주도 팩", description: "제주도의 카드가\n포함된 카드팩", credit: 300_000, colorable: LegacyColor.Red.netural),
        PackModel(id: 9, name: "강원도 팩", description: "강원도의 카드가\n포함된 카드팩", credit: 300_000, colorable: LegacyColor.Red.netural)
    ]
    
    let dummyBluePacks = [
        PackModel(id: 10, name: "역사&학문 팩", description: "역사를 잊는 민족에게\n미래는 없다.", credit: 300_000, colorable: LegacyColor.Blue.netural),
        PackModel(id: 11, name: "예술&기술 팩", description: "고도로 발달한 기술은\n마법과 구별할 수 없다.", credit: 300_000, colorable: LegacyColor.Blue.netural),
        PackModel(id: 12, name: "신앙&체제 팩", description: "교회가 국가를 대신할 수\n없듯이, 국가는 교회를 대신할 수 없다.", credit: 300_000, colorable: LegacyColor.Blue.netural),
        PackModel(id: 13, name: "놀이&의식주 팩", description: "현재는 선물이다.\n그러니 걱정 말고 맘껏 즐거라.", credit: 300_000, colorable: LegacyColor.Blue.netural)
    ]
    
    
    var body: some View {
        LegacyView {
            LegacyScrollView(title: "상점", icon: .shop, item: tabItem) {
                VStack(spacing: 16) {
                    HStack {
                        CategoryButtonGroup(
                            categories: ["카드 팩", "크래딧 충전"],
                            selection: $selection
                        )
                        
                        Spacer()
                    }
                    .padding(.horizontal, 14)
                    
                    if selection == 0 {
                        AdvertiseView(viewModel: viewModel)
                        
                        
                        LazyVGrid(columns: columns, spacing: 8) {
                            ForEach(dummyPurplePacks) { pack in
                                PackButton(
                                    title: pack.name,
                                    description: pack.description,
                                    credit: "\(pack.credit.formatted())",
                                    strokeColor: pack.colorable
                                ) {
                                    
                                }
                            }
                        }
                        .padding(.horizontal, 14)
                        
                        
                        LazyVGrid(columns: columns, spacing: 8) {
                            ForEach(dummyBluePacks) { pack in
                                PackButton(
                                    title: pack.name,
                                    description: pack.description,
                                    credit: "\(pack.credit.formatted())",
                                    strokeColor: pack.colorable
                                ) {
                                    
                                }
                            }
                        }
                        .padding(.horizontal, 14)
                        
                        
                        LazyVGrid(columns: columns, spacing: 8) {
                            ForEach(dummyRedPacks) { pack in
                                PackButton(
                                    title: pack.name,
                                    description: pack.description,
                                    credit: "\(pack.credit.formatted())",
                                    strokeColor: pack.colorable
                                ) {
                                    
                                }
                            }
                        }
                        .padding(.horizontal, 14)
                        
                    } else {
                        VStack {
                            Spacer()
                            LegacyLoadingView(
                                description: ""
                            )
                        }
                    }
                }
            }
        }
        .onAppear {
            //MARK: 상점 브금 로그인 브금으로 대채
            SoundPlayer.shared.loginSound()
        }
    }
}
