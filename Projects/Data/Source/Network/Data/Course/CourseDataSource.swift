//
//  CourseDataSource.swift
//  Data
//
//  Created by 김은찬 on 8/7/25.
//

import Foundation
import Domain

public struct CourseDataSource: DataSourceProtocol {
    public typealias Target = CourseService
    
    public init() {}
    
    public func fetchCourse() async throws -> [CourseResponse] {
        let response: BaseResponse<[CourseResponse]> = try await self.request(target: .fetchCourse)
        return response.data
    }
}
