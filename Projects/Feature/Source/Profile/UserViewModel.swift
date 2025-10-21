//
//  UserViewModel.swift
//  Feature
//

import Foundation
import DIContainer
import Domain
import Data

public class UserViewModel: ObservableObject, APIMessageable {
    @Published public var successMessage: String = ""
    @Published public var errorMessage: String = ""
    
    @Published var userInfo: UserInfoResponse?
    @Published var isLoading: Bool = false
    @Published var profileImageUrl: String = ""
    @Published var imageUrlResponse: ImageUrlResponse?
    @Published var image: Data?
    
    @Published var titleList: [UserTitleResponse]?
    
    @Inject var userRepository: any UserRepository
    
    public init() {}
    
    @MainActor
    func fetchMyinfo() async {
        guard !isLoading else { return }
        isLoading = true
        defer { isLoading = false }
        
        do {
            userInfo = try await userRepository.fetchMyinfo()
        } catch {
            print("\(error) fetchMyinfo 에러")
        }
    }
    
    @MainActor
    func editProfileImage() async {
        guard let image else { return }
        
        do {
            let fileName = UUID().uuidString + ".jpg"
            imageUrlResponse = try await userRepository.uploadUrl(fileName)
            guard let uploadUrl = imageUrlResponse?.uploadUrl else { return }
            try await uploadImage(to: uploadUrl, data: image)
        } catch {
            print("\(error) 업로드 에러")
        }
    }
    
    private func uploadImage(to url: String, data: Data) async throws {
        guard let uploadUrl = URL(string: url) else { throw URLError(.badURL) }
        
        var request = URLRequest(url: uploadUrl)
        request.httpMethod = "PUT"
        request.setValue("image/jpeg", forHTTPHeaderField: "Content-Type")
        request.setValue("public-read", forHTTPHeaderField: "x-amz-acl")
        
        let (_, response) = try await URLSession.shared.upload(for: request, from: data)
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
    }
    
    @MainActor
    func editProfile() async {
        guard let imageUrl = imageUrlResponse?.imageUrl else { return }
        
        do {
            try await userRepository.changeProfileImage(.init(profileImageUrl: imageUrl))
            successMessage = "저장 완료!"
        } catch let apiError as APIError {
            errorMessage = apiError.message
        } catch {
            print("에러: \(error)")
        }
    }
    
    @MainActor
    func fetchTitle() async {
        do {
            titleList = try await userRepository.fetchTitle()
        } catch {
            print("에러: \(error)")
        }
    }
    
    @MainActor
    func applyTitle(_ styleId: Int) async {
        do {
            try await userRepository.applyTitle(styleId)
            successMessage = "칭호 장착 완료!"
        } catch let apiError as APIError {
            errorMessage = apiError.message
        } catch {
            print("에러: \(error)")
        }
    }
}
