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
}
