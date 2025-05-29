import DIContainer
import Domain
import Swinject

public extension DependencyProvider {
    func register() {
        _ = Assembler([
            DataSourceAssembly(),
            RepositoryAssembly()
        ], container: container)
    }
}
