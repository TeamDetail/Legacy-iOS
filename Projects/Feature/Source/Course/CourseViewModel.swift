//
//  CourseViewModel.swift
//  Feature
//
//  Created by 김은찬 on 8/7/25.
//

import Foundation
import DIContainer
import Domain
import Data

public class CourseViewModel: ObservableObject {
    @Published var courses: [CourseResponse]?
    
    @Inject var courseRepository: any CourseRepository
    
    @MainActor
    func fetchCourse() async {
        do {
            courses = try await courseRepository.fetchCourse()
            print(courses)
        } catch {
            print(error.localizedDescription)
        }
    }
}
