//
//  MailResponse.swift
//  Domain
//
//  Created by 김은찬 on 9/14/25.
//

import Foundation

public struct MailResponse: ResponseProtocol {
    public let mailTitle: String
    public let mailContent: String
    public let sendAt: String
    public let itemData: [MailItem]
    
    public init(mailTitle: String, mailContent: String, sendAt: String, itemData: [MailItem]) {
        self.mailTitle = mailTitle
        self.mailContent = mailContent
        self.sendAt = sendAt
        self.itemData = itemData
    }
}
