//
//  DataSourceAssembly.swift
//  Legacy
//
//  Created by 김은찬 on 5/29/25.
//

import Swinject
import Data

public struct DataSourceAssembly: Assembly {
    public init() {}
    
    public func assemble(container: Container) {
        container.register(AuthDataSource.self) { _ in
            AuthDataSource()
        }.inObjectScope(.container)
        
        container.register(ExploreDataSource.self) { _ in
            ExploreDataSource()
        }.inObjectScope(.container)
        
        container.register(UserDataSource.self) { _ in
            UserDataSource()
        }.inObjectScope(.container)
    }
}
