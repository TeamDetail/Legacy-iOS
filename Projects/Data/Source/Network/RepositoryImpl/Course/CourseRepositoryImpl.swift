//
//  CourseRepositoryImpl.swift
//  Data
//
//  Created by 김은찬 on 8/7/25.
//

import Foundation
import Domain

public struct CourseRepositoryImpl: CourseRepository {
    let dataSource: CourseDataSource
    
    public init(dataSource: CourseDataSource) {
        self.dataSource = dataSource
    }
    
    public func fetchCourse() async throws -> [CourseResponse] {
        let data = try await dataSource.fetchCourse()
        return data
    }
}
