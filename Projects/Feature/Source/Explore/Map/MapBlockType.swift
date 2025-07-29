//
//  MapBlockType.swift
//  Feature
//
//  Created by 김은찬 on 7/29/25.
//

import UIKit
import Component
import Foundation

enum MapBlockType {
    case myBlock(_ blockType: String)
    case ruins(_ ruinsId: Int, isOverlapped: Bool)
    
    var strokeColor: UIColor {
        switch self {
        case .myBlock:
            return UIColor(LegacyPalette.shared.green40)
        case .ruins(_, let isOverlapped):
            return isOverlapped
            ? UIColor(LegacyPalette.shared.yellowNetural)
            : UIColor(LegacyPalette.shared.primary)
        }
    }
    
    var fillColor: UIColor {
        switch self {
        case .myBlock:
            return UIColor(LegacyPalette.shared.greenNormal)
        case .ruins(_, let isOverlapped):
            return isOverlapped
            ? UIColor(LegacyPalette.shared.yellowNormal)
            : UIColor(LegacyPalette.shared.purpleNetural)
        }
    }
    
    var isTappable: Bool {
        switch self {
        case .myBlock:
            return false
        case .ruins:
            return true
        }
    }
    
    var userData: Any? {
        switch self {
        case .ruins(let ruinsId, _):
            return ruinsId
        case .myBlock:
            return nil
        }
    }
}

struct MapBlock {
    let latitude: Double
    let longitude: Double
    let type: MapBlockType
}
