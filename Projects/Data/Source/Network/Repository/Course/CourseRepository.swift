//
//  CourseRepository.swift
//  Data
//
//  Created by 김은찬 on 8/7/25.
//

import Foundation
import Domain

public protocol CourseRepository {
    func fetchCourse() async throws -> [CourseResponse]
    func fetchRecentCourse() async throws -> [CourseResponse]
    func fetchPopularCourse() async throws -> [CourseResponse]
    func fetchEventCourse() async throws -> [CourseResponse]
    func likeCourse(_ courseId: Int) async throws
}
