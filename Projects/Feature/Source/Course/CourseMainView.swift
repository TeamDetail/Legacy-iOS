//
//  CourseMainView.swift
//  Feature
//
//  Created by 김은찬 on 7/31/25.
//

import SwiftUI
import Component
import Data

struct CourseMainView: View {
    @Binding var selection: Int
    var body: some View {
        VStack(spacing: 30) {
            VStack(spacing: 6) {
                SectionHeaderView(sectionType: .popular)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(1...3, id:\.self) { _ in
                            CourseCard(url: "https://i.namu.wiki/i/qk2PBmx-wOMXOXJr694iSye5c7iid5woqBVZgzYmW4Ipyis6J1fpHlGamR066-4EarGHN0anDZKgtNZGg332gA.webp")
                        }
                        DetailButton {
                            selection = 1
                        }
                    }
                }
            }
            
            VStack(spacing: 6) {
                SectionHeaderView(sectionType: .event)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(1...3, id:\.self) { _ in
                            CourseCard(url: "https://i.namu.wiki/i/BmVN22x-0Tz8G6PJCBbFjB_Km4HfIxSZLvXzVRcFwJh7TDkpPh3vzk9vSmadHvpTHDBk2v1rwSDHvX4OljZJdA.webp")
                        }
                        DetailButton {
                            selection = 1
                        }
                    }
                }
            }
            
            VStack(spacing: 6) {
                SectionHeaderView(sectionType: .recent)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(1...3, id:\.self) { _ in
                            CourseCard(url: "https://i.namu.wiki/i/E4QM2ztcw0Arj_PkLpNR_5apEXijC7OFfqn69KhDMwlq59ge5XxDMofK03OBGkaAQgaoY9jZkNgZAMb5Eur-tQ.webp")
                        }
                        DetailButton {
                            selection = 1
                        }
                    }
                }
            }
            VStack {
                CourseButton(title: "목록으로 보기") {
                    selection = 1
                }
            }
            .padding(.horizontal, 20)
        }
        .padding(4)
    }
}
