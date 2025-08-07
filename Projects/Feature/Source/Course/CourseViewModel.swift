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
    @Published var recentCourses: [CourseResponse]?
    @Published var popularCourses: [CourseResponse]?
    @Published var eventCourses: [CourseResponse]?
    
    @Inject var courseRepository: any CourseRepository
    
    @MainActor
    func fetchCourse() async {
        do {
            courses = try await courseRepository.fetchCourse()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @MainActor
    func fetchRecentCourse() async {
        do {
            recentCourses = try await courseRepository.fetchRecentCourse()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @MainActor
    func fetchPopularCourse() async {
        do {
            popularCourses = try await courseRepository.fetchPopularCourse()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @MainActor
    func fetchEventCourse() async {
        do {
            eventCourses = try await courseRepository.fetchEventCourse()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @MainActor
    func likeCourse(_ courseId: Int) async {
        do {
            try await courseRepository.likeCourse(courseId)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @MainActor
    func fetchAllData() async {
        courses = nil
        recentCourses = nil
        popularCourses = nil
        eventCourses = nil
        async let fetchCourse: () = fetchCourse()
        async let fetchRecentCourse: () = fetchRecentCourse()
        async let fetchPopularCourse: () = fetchPopularCourse()
        async let fetchEventCourse: () = fetchEventCourse()
        _ = await [fetchCourse, fetchRecentCourse, fetchPopularCourse, fetchEventCourse]
    }
}
