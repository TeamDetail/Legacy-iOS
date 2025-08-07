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
    
    public func fetchRecentCourse() async throws -> [CourseResponse] {
        let data = try await dataSource.fetchRecentCourse()
        return data
    }
    
    public func fetchPopularCourse() async throws -> [CourseResponse] {
        let data = try await dataSource.fetchPopularCourse()
        return data
    }
    
    public func fetchEventCourse() async throws -> [CourseResponse] {
        let data = try await dataSource.fetchEventCourse()
        return data
    }
    
    public func likeCourse(_ courseId: Int) async throws {
        try await dataSource.likeCourse(courseId)
    }
}
