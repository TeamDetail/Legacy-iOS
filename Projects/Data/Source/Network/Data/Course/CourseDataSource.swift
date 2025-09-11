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
    
    public func fetchRecentCourse() async throws -> [CourseResponse] {
        let response: BaseResponse<[CourseResponse]> = try await self.request(target: .fetchRecentCourse)
        return response.data
    }
    
    public func fetchPopularCourse() async throws -> [CourseResponse] {
        let response: BaseResponse<[CourseResponse]> = try await self.request(target: .fetchPopularCourse)
        return response.data
    }
    
    public func fetchEventCourse() async throws -> [CourseResponse] {
        let response: BaseResponse<[CourseResponse]> = try await self.request(target: .fetchEventCourse)
        return response.data
    }
    
    public func likeCourse(_ courseId: Int) async throws {
        let _: BaseResponse<String> = try await self.request(target: .likeCourse(courseId))
    }
    
    public func fetchCourseDetail(_ courseId: Int) async throws -> CourseDetailResponse {
        let response: BaseResponse<CourseDetailResponse> = try await self.request(target: .fetchCourseDetail(courseId))
        return response.data
    }
    
    public func createCourse(_ request: CourseRequest) async throws -> CourseResponse {
        let response: BaseResponse<CourseResponse> = try await self.request(target: .createCourse(request))
        return response.data
    }
}
