//
//  TitleData.swift
//  Domain
//
//  Created by 김은찬 on 6/23/25.
//

import Foundation

public struct TitleData: ResponseProtocol {
    public let name: String
    public let content: String
    public let styleId: Int
    public let grade: Int
}
