//
//  FriendsType.swift
//  Domain
//
//  Created by 김은찬 on 10/1/25.
//

import Foundation

public enum FriendsStatusType: String, EnumProtocol {
    case pending = "PENDING"
    case accept = "ACCEPTED"
    case decline = "DECLINED"
}
