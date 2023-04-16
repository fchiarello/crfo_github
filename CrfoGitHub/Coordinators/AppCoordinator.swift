import UIKit

protocol AppCoordinator: AnyObject {
    func addChildCoordinator(_ coordinator: AppCoordinator)
    func removeAllChildCoordinatorsWith<T>(type: T.Type)
    func removeAllChildCoordinators()
}


