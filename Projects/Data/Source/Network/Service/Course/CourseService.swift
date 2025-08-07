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
}

extension CourseService {
    public var host: String {
        "/course"
    }
    
    public var path: String {
        switch self {
        case .fetchCourse:
            ""
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .fetchCourse: .get
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case .fetchCourse: .requestPlain
        }
    }
}
