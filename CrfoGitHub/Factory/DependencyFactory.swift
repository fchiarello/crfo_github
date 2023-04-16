import Foundation

protocol FactoryProtocol {
    var serviceManager: ServiceProtocol { get }
    
    func makeUsersViewController(coordinator: UserCoordinator) -> UsersViewController
    func makeUsersViewModel(coordinator: Coordinator) -> UsersViewModel
}

final class Factory: FactoryProtocol {
    var serviceManager: ServiceProtocol = Service()
    
    func makeUsersViewController(coordinator: UserCoordinator) -> UsersViewController {
        let viewModel = self.makeUsersViewModel(coordinator: coordinator)
        let viewController = UsersViewController()
        
        return viewController
    }
    
    func makeUsersViewModel(coordinator: Coordinator) -> UsersViewModel {
        UsersViewModel()
    }
    
    func makeUserCoordinator() -> UserCoordinator {
        UserCoordinator(factory: self)
    }
}
