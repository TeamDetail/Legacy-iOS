//
//  RuinsDetailResponse.swift
//  Domain
//
//  Created by 김은찬 on 6/21/25.
//

import Foundation

public struct RuinsDetailResponse: ResponseProtocol {
    public let ruinsId: Int
    public let ruinsImage: String
    public let category: String
    public let name: String
    public let chineseName: String?
    public let englishName: String?
    public let location: String
    public let detailAddress: String
    public let periodName: String
    public let specifiedDate: String
    public let owner: String
    public let manager: String
    public let latitude: Double
    public let longitude: Double
    public let description: String
    public let averageRating: Double
    public let countComments: Int
    public let card: Card?
    
    public init(ruinsId: Int, ruinsImage: String, category: String, name: String, chineseName: String?, englishName: String?, location: String, detailAddress: String, periodName: String, specifiedDate: String, owner: String, manager: String, latitude: Double, longitude: Double, description: String, averageRating: Double, countComments: Int, card: Card?) {
        self.ruinsId = ruinsId
        self.ruinsImage = ruinsImage
        self.category = category
        self.name = name
        self.chineseName = chineseName
        self.englishName = englishName
        self.location = location
        self.detailAddress = detailAddress
        self.periodName = periodName
        self.specifiedDate = specifiedDate
        self.owner = owner
        self.manager = manager
        self.latitude = latitude
        self.longitude = longitude
        self.description = description
        self.averageRating = averageRating
        self.countComments = countComments
        self.card = card
    }
}
