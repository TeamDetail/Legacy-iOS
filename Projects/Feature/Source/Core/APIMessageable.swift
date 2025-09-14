//
//  APIMessageable.swift
//  Feature
//
//  Created by 김은찬 on 9/14/25.
//

import Combine
import Foundation

public protocol APIMessageable: ObservableObject {
    var successMessage: String { get set }
    var errorMessage: String { get set }
}
