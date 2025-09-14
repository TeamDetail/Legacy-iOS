import Foundation

public struct BaseResponse<T: Decodable>: Decodable, Sendable {
    public let status: Int
    public let data: T
    
    public init(status: Int, data: T) {
        self.status = status
        self.data = data
    }
}

//MARK: ?
//public struct BaseResponse<T: Decodable>: Decodable, Sendable {
//    public let status: Int
//    public let data: T?
//    public let message: String?
//
//    public init(status: Int, data: T? = nil, message: String? = nil) {
//        self.status = status
//        self.data = data
//        self.message = message
//    }
//}
