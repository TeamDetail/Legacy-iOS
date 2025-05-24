//
//  DataSourceProtocol.swift
//  Data
//
//  Created by 김은찬 on 5/23/25.
//

import Moya
import Domain

public protocol DataSourceProtocol {
    associatedtype Target: TargetType
    var provider: MoyaProvider<Target> { get }
    
    func request<T: Decodable>(target: Target) async throws -> BaseResponse<T>
}
