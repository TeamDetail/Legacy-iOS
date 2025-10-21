//
//  CreditResponse.swift
//  Domain
//
//  Created by 김은찬 on 10/22/25.
//

import Foundation

public struct CreditResponse: ResponseProtocol {
    public let addedCredit: Int
    public let userTotalCredit: Int
    
    public init(addedCredit: Int, userTotalCredit: Int) {
        self.addedCredit = addedCredit
        self.userTotalCredit = userTotalCredit
    }
}
