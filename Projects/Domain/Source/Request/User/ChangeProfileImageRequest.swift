import Foundation

public struct ChangeProfileImageRequest: RequestProtocol {
    public let profileImageUrl: String
    
    public init(profileImageUrl: String) {
        self.profileImageUrl = profileImageUrl
    }
}
