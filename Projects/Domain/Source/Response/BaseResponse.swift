import Foundation

public struct BaseResponse<T: ResponseProtocol>: ResponseProtocol {
    
    public let status: Int
    public let message: String
    public let data: T
    
    public init(status: Int, message: String, data: T) {
        self.status = status
        self.message = message
        self.data = data
    }
}

