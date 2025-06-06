//
//  RepositoryAssembly.swift
//  Legacy
//
//  Created by 김은찬 on 5/29/25.
//

import Swinject
import Data
import Domain

public struct RepositoryAssembly: Assembly {
    public init() {}
    
    public func assemble(container: Container) {
        container.register(AuthRepository.self) { resolver in
            let dataSource = resolver.resolve(AuthDataSource.self)!
            return AuthRepositoryImpl(dataSource: dataSource)
        }.inObjectScope(.container)
    }
}
