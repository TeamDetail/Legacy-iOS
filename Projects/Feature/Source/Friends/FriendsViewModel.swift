//
//  FriendsViewModel.swift
//  Feature
//
//  Created by 김은찬 on 10/2/25.
//

import Foundation
import DIContainer
import Domain
import Data

public class FriendsViewModel: ObservableObject {
    @Published var myCode: String?
    @Published var friendsList: [FriendsResponse]?
    @Inject var friendsRepository: any FriendsRepository
    
    
    @MainActor
    func fetchMyFriends() async {
        do {
            friendsList = try await friendsRepository.fetchMyFriends()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @MainActor
    func fetchMyCode() async {
        do {
            myCode = try await friendsRepository.fetchMyCode()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @MainActor
    func fetchAllData() async {
        myCode = nil
        friendsList = nil
        async let fetchMyFriends: () = fetchMyFriends()
        async let fetchMyCode: () = fetchMyCode()
        _ = await [fetchMyFriends, fetchMyCode]
    }
}
