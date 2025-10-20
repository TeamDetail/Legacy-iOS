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
        
        container.register(QuizDataSource.self) { _ in
            QuizDataSource()
        }.inObjectScope(.container)
        
        container.register(RankDataSource.self) { _ in
            RankDataSource()
        }.inObjectScope(.container)
        
        container.register(CardDataSource.self) { _ in
            CardDataSource()
        }.inObjectScope(.container)
        
        container.register(CourseDataSource.self) { _ in
            CourseDataSource()
        }.inObjectScope(.container)
        
        container.register(StoreDataSource.self) { _ in
            StoreDataSource()
        }.inObjectScope(.container)
        
        container.register(InventoryDataSource.self) { _ in
            InventoryDataSource()
        }.inObjectScope(.container)
        
        container.register(MailDataSource.self) { _ in
            MailDataSource()
        }.inObjectScope(.container)
        
        container.register(AchievementDataSource.self) { _ in
            AchievementDataSource()
        }.inObjectScope(.container)
        
        container.register(FriendsDataSource.self) { _ in
            FriendsDataSource()
        }.inObjectScope(.container)
        
        container.register(DailyDataSource.self) { _ in
            DailyDataSource()
        }.inObjectScope(.container)
        
        container.register(BlockRepository.self) { _ in //MARK: 나중에 구현
            BlockService()
        }.inObjectScope(.container)
    }
}
