//
//  LoactionEnum.swift
//  Component
//
//  Created by 김은찬 on 7/24/25.
//

import Foundation

public enum RegionEnum: String, CaseIterable {
    case Gyeonggi
    case Gangwon
    case Gyeongbuk
    case Gyeongnam
    case Jeonbuk
    case Jeonnam
    case Chungbuk
    case Chungnam
    case Jeju
    
    public var regionName: String {
        switch self {
        case .Gyeonggi:
            return "경기"
        case .Gangwon:
            return "강원"
        case .Gyeongbuk:
            return "경북"
        case .Gyeongnam:
            return "경남"
        case .Jeonbuk:
            return "전북"
        case .Jeonnam:
            return "전남"
        case .Chungbuk:
            return "충북"
        case .Chungnam:
            return "충남"
        case .Jeju:
            return "제주"
        }
    }
}
