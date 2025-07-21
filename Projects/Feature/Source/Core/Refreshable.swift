//
//  Refreshable.swift
//  Feature
//
//  Created by 김은찬 on 7/21/25.
//

import Foundation

@MainActor
protocol Refreshable {
    func onRefresh() async
    func clearData()
}
