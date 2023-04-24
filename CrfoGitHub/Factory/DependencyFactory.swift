import Foundation

protocol FactoryProtocol {
    var serviceManager: ServiceProtocol { get }
    
    func makeUsersViewController(coordinator: UserCoordinator) -> UsersViewController
    func makeUsersViewModel(coordinator: Coordinator) -> UsersViewModel
    
    func makeUserDetailViewController(coordinator: UserCoordinator) -> UserDetailViewController
    func makeUserDetailViewModel(coordinator: UserCoordinator) -> UserDetailViewModel
}

final class Factory: FactoryProtocol {
    var serviceManager: ServiceProtocol = Service()
    
    func makeUsersViewController(coordinator: UserCoordinator) -> UsersViewController {
        let viewModel = self.makeUsersViewModel(coordinator: coordinator)
        let viewController = UsersViewController(coordinator: coordinator,
                                                 viewModel: viewModel)
        
        return viewController
    }
    
    func makeUsersViewModel(coordinator: Coordinator) -> UsersViewModel {
        UsersViewModel(coordinator: coordinator,
                       service: self.serviceManager)
    }
    
    func makeUserCoordinator() -> UserCoordinator {
        UserCoordinator(factory: self)
    }
    
    func makeUserDetailViewController(coordinator: UserCoordinator) -> UserDetailViewController {
        let viewModel = makeUserDetailViewModel(coordinator: coordinator)
        let viewController = UserDetailViewController(viewModel: viewModel)
        return viewController
    }
    
    func makeUserDetailViewModel(coordinator: UserCoordinator) -> UserDetailViewModel {
        UserDetailViewModel(coordinator: coordinator,
                            service: self.serviceManager)
    }
}
