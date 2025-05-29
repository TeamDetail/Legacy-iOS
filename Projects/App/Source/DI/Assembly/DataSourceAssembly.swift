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
    }
}
