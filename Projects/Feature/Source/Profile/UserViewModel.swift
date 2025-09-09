//
//  UserViewModel.swift
//  Feature
//

import Foundation
import DIContainer
import Domain
import Data

public class UserViewModel: ObservableObject {
    @Published var userInfo: UserInfoResponse?
    @Published var isLoading: Bool = false
    @Published var profileImageUrl: String = ""
    @Published var image: Data?
    @Inject var userRepository: any UserRepository
    
    public init() {}
    
    @MainActor
    func fetchMyinfo() async {
        guard !isLoading else { return } // 중복 호출 방지
        isLoading = true
        defer { isLoading = false }
        
        do {
            userInfo = try await userRepository.fetchMyinfo()
        } catch {
            print("\(error) 에러")
        }
    }
    
    @MainActor
    func editProfileImage() async {
        guard let image else { return }
        
        do {
            // 파일명 생성
            let fileName = UUID().uuidString + ".jpg"
            let presignedUrl = try await userRepository.uploadUrl(fileName)
            try await uploadImage(to: presignedUrl, data: image)
            try await userRepository.changeProfileImage(.init(profileImageUrl: presignedUrl))
            await fetchMyinfo()
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
    func refreshUserInfo() async {
        await fetchMyinfo()
    }
}
