//
//  CourseService.swift
//  Data
//
//  Created by 김은찬 on 8/7/25.
//


import Moya
import Domain

public enum CourseService: ServiceProtocol {
    case fetchCourse
    case fetchRecentCourse
    case fetchPopularCourse
    case fetchEventCourse
    case likeCourse(_ courseId: Int)
    case fetchCourseDetail(_ courseId: Int)
}

extension CourseService {
    public var host: String {
        "/course"
    }
    
    public var path: String {
        switch self {
        case .fetchCourse:
            ""
        case .fetchRecentCourse:
            "/recent"
        case .fetchPopularCourse:
            "/popular"
        case .fetchEventCourse:
            "/event"
        case .likeCourse:
            ""
        case .fetchCourseDetail(let courseId):
            "/\(courseId)"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .fetchCourse: .get
        case .fetchRecentCourse: .get
        case .fetchPopularCourse: .get
        case .fetchEventCourse: .get
        case .likeCourse: .patch
        case .fetchCourseDetail: .get
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case .fetchCourse:
            return .requestPlain
        case .fetchRecentCourse:
            return .requestPlain
        case .fetchPopularCourse:
            return .requestPlain
        case .fetchEventCourse:
            return .requestPlain
        case let .likeCourse(courseId):
            return .requestParameters(
                parameters: ["courseId": courseId],
                encoding: JSONEncoding.default
            )
        case .fetchCourseDetail(_ ):
            return .requestPlain
        }
    }
}
