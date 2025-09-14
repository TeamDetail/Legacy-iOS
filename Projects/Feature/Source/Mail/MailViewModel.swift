//
//  MailViewModel.swift
//  Feature
//
//  Created by 김은찬 on 9/14/25.
//

import Foundation
import DIContainer
import Domain
import Data

public class MailViewModel: ObservableObject {
    @Published var myMail: [MailResponse]?
    @Published var rewardMails: [MailResponse]?
    @Published var selectMail: MailResponse?
    @Inject var mailRepository: any MailRepository
    
    @MainActor
    func fetchMail() async {
        do {
            myMail = try await mailRepository.fetchMail()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @MainActor
    func postAward() async {
        do {
            rewardMails = try await mailRepository.postAward()
            await fetchMail()
        } catch {
            print(error.localizedDescription)
        }
    }
}
