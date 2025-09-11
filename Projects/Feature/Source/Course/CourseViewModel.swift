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
    @Published var courseDetail: CourseDetailResponse?
    
    @Published var searchResult: [RuinsDetailResponse]?
    @Published var isLoading = false
    
    @Inject var courseRepository: any CourseRepository
    @Inject var ruinsRepository: any ExploreRepository
    
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
    func fetchCourseDatail(_ courseId: Int) async {
        courseDetail = nil
        do {
            courseDetail = try await courseRepository.fetchCourseDetail(courseId)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @MainActor
    func createCourse(_ request: CourseRequest) async {
        do {
            _ = try await courseRepository.createCourse(request)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    //MARK: 유적지를 찾기 위해 ruinsRepository에서 가져옴
    @MainActor
    func searchRuins(_ ruinsName: String) async {
        isLoading = true
        do {
            searchResult = try await ruinsRepository.searchRuins(ruinsName)
            isLoading = false
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
