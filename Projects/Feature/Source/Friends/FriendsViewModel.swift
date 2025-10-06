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

class FriendsViewModel: ObservableObject, APIMessageable {
    @Published var successMessage: String = ""
    @Published var errorMessage: String = ""
    
    @Published var isLoading: Bool = false
    @Published var myCode: String?
    @Published var friendsList: [FriendsResponse]? // 내친구 목록
    @Published var searchResult: [SearchFriendsResponse]? // 검색 결과
    @Published var requestFriendsList: [FriendRequestResponse]? // 보낸 친추
    @Published var sentFriendsList: [FriendRequestResponse]? // 대기중 친추
    @Inject var friendsRepository: any FriendsRepository
    
    // MARK: - Post
    @MainActor
    func requestFriend(_ friendsCode: String) async {
        do {
            successMessage = try await friendsRepository.requestFriend(friendsCode)
        } catch let apiError as APIError {
            errorMessage = apiError.message
        } catch {
            print("에러: \(error)")
        }
    }
    
    @MainActor
    func acceptFriend(_ requestId: Int) async {
        do {
            successMessage = try await friendsRepository.acceptFriend(requestId)
        } catch let apiError as APIError {
            errorMessage = apiError.message
        } catch {
            print("에러: \(error)")
        }
    }
    
    @MainActor
    func refuseFriend(_ requestId: Int) async {
        do {
            successMessage = try await friendsRepository.refuseFriend(requestId)
        } catch let apiError as APIError {
            errorMessage = apiError.message
        } catch {
            print("에러: \(error)")
        }
    }
    
    //MARK: 이건 나중에..;;
    @MainActor
    func requestAutoKakaoFriend(_ authorization: String) async {
        do {
            _ = try await friendsRepository.requestAutoKakaoFriend(authorization)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // MARK: - Get
    @MainActor
    func fetchMyCode() async {
        do {
            myCode = try await friendsRepository.fetchMyCode()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @MainActor
    func fetchMyFriends() async {
        isLoading = true
        do {
            friendsList = try await friendsRepository.fetchMyFriends()
        } catch {
            print(error.localizedDescription)
        }
        isLoading = false
    }
    
    @MainActor
    func searchFriends(_ nickName: String) async {
        do {
            searchResult = try await friendsRepository.searchFriends(nickName)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @MainActor
    func fetchRequestFriend() async {
        do {
            requestFriendsList = try await friendsRepository.fetchRequestFriend()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @MainActor
    func fetchSentRequests() async {
        do {
            sentFriendsList = try await friendsRepository.fetchSentRequests()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // MARK: - Delete
    @MainActor
    func deleteFriend(_ requestId: Int) async {
        do {
            successMessage = try await friendsRepository.deleteFriend(requestId)
        } catch let apiError as APIError {
            errorMessage = apiError.message
        } catch {
            print("에러: \(error)")
        }
    }
    
    @MainActor
    func cancelSentRequest(_ requestId: Int) async {
        do {
            successMessage = try await friendsRepository.cancelSentRequest(requestId)
        } catch let apiError as APIError {
            errorMessage = apiError.message
        } catch {
            print("에러: \(error)")
        }
    }
    
    // MARK: - All
    @MainActor
    func fetchAllData() async {
        myCode = nil
        friendsList = nil
        requestFriendsList = nil
        sentFriendsList = nil
        async let fetchMyFriends: () = fetchMyFriends()
        async let fetchMyCode: () = fetchMyCode()
        async let fetchRequestFriend: () = fetchRequestFriend()
        async let fetchSentRequests: () = fetchSentRequests()
        _ = await [fetchMyFriends, fetchMyCode, fetchRequestFriend, fetchSentRequests]
    }
}
