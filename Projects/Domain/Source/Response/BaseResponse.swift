import Foundation

public struct BaseResponse<T: Decodable>: Decodable {
    public let status: Int
    public let data: T
    
    public init(status: Int, data: T) {
        self.status = status
        self.data = data
    }
}
