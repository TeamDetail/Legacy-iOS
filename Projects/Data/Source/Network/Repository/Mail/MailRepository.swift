//
//  MailRepository.swift
//
//
//  Created by 김은찬 on 9/14/25.
//

import Foundation
import Domain

public protocol MailRepository {
    func fetchMail() async throws -> [MailResponse]
    func postAward() async throws -> [MailResponse]
}
