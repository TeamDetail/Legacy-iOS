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
        
        container.register(ExploreRepository.self) { resolver in
            let dataSource = resolver.resolve(ExploreDataSource.self)!
            return ExploreRepositoryImpl(dataSource: dataSource)
        }.inObjectScope(.container)
        
        container.register(UserRepository.self) { resolver in
            let dataSource = resolver.resolve(UserDataSource.self)!
            return UserRepositoryImpl(dataSource: dataSource)
        }.inObjectScope(.container)
        
        container.register(QuizRepository.self) { resolver in
            let dataSource = resolver.resolve(QuizDataSource.self)!
            return QuizRepositorylmpl(dataSource: dataSource)
        }.inObjectScope(.container)
        
        container.register(RankRepository.self) { resolver in
            let dataSource = resolver.resolve(RankDataSource.self)!
            return RankRepositorylmpl(dataSource: dataSource)
        }.inObjectScope(.container)
    }
}
