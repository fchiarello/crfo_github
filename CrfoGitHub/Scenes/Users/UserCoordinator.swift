import UIKit

final class UserCoordinator: AppCoordinator {
    private(set) var childCoordinators: [AppCoordinator] = []
    weak var navigationController: UINavigationController?
    private var factory: FactoryProtocol
    
    init(factory: FactoryProtocol) {
        self.factory = factory
    }
    
    func addChildCoordinator(_ coordinator: AppCoordinator) {
        childCoordinators.append(coordinator)
    }
    
    func removeAllChildCoordinatorsWith<T>(type: T.Type) {
        childCoordinators = childCoordinators.filter { $0 is T  == false }
    }
    
    func removeAllChildCoordinators() {
        childCoordinators.removeAll()
    }
}

extension UserCoordinator: Coordinator {
    func start(_ navigationController: UINavigationController) {
        let viewController = factory.makeUsersViewController(coordinator: self)
        self.navigationController = navigationController
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func errorAlert(completion: @escaping (() -> Void)) {
        print("<<<<<<<<ERROR>>>>>>")
    }
    
    func moveToDetail(login: String) {
        let viewController = factory.makeUserDetailViewController(coordinator: self)
        viewController.login = login
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func openRepoURL(urlString: String) {
        guard let url = URL(string: urlString) else {
          return
        }
        
        UIApplication.shared.open(url)
    }
}
