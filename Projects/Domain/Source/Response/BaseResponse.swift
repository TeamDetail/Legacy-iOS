import Foundation

public struct BaseResponse<T: ResponseProtocol>: ResponseProtocol {
    
    public let status: Int
    public let data: T
    
    public init(status: Int, data: T) {
        self.status = status
        self.data = data
    }
}

