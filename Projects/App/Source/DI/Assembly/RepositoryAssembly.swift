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
            return QuizRepositoryImpl(dataSource: dataSource)
        }.inObjectScope(.container)
        
        container.register(RankRepository.self) { resolver in
            let dataSource = resolver.resolve(RankDataSource.self)!
            return RankRepositoryImpl(dataSource: dataSource)
        }.inObjectScope(.container)
        
        container.register(CardRepository.self) { resolver in
            let dataSource = resolver.resolve(CardDataSource.self)!
            return CardRespositoryImpl(dataSource: dataSource)
        }.inObjectScope(.container)
        
        container.register(CourseRepository.self) { resolver in
            let dataSource = resolver.resolve(CourseDataSource.self)!
            return CourseRepositoryImpl(dataSource: dataSource)
        }.inObjectScope(.container)
        
        container.register(InventoryRepository.self) { resolver in
            let dataSource = resolver.resolve(InventoryDataSource.self)!
            return InventoryRepositoryImpl(dataSource: dataSource)
        }.inObjectScope(.container)
        
        container.register(StoreRepository.self) { resolver in
            let dataSource = resolver.resolve(StoreDataSource.self)!
            return StoreRepositoryImpl(dataSource: dataSource)
        }.inObjectScope(.container)
        
        container.register(MailRepository.self) { resolver in
            let dataSource = resolver.resolve(MailDataSource.self)!
            return MailRepositoryImpl(dataSource: dataSource)
        }.inObjectScope(.container)
    }
}
