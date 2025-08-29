import Foundation

public struct UploadUrlRequest: RequestProtocol {
    public let fileName: String
    
    public init(fileName: String) {
        self.fileName = fileName
    }
}
