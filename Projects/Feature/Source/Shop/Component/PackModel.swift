//
//  PackModel.swift
//  Feature
//
//  Created by 김은찬 on 7/17/25.
//

import Foundation
import Component
import SwiftUI

struct PackModel: Identifiable, Hashable {
    let id: Int
    let name: String
    let description: String
    let credit: Int
    let colorable: any LegacyColorable
    
    var color: LegacyColor {
        colorable.color
    }
    
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
        hasher.combine(description)
        hasher.combine(credit)
    }
    
    static func == (lhs: PackModel, rhs: PackModel) -> Bool {
        return lhs.id == rhs.id &&
        lhs.name == rhs.name &&
        lhs.description == rhs.description &&
        lhs.credit == rhs.credit
    }
}
