import UIKit

protocol Coordinator: AnyObject {
    func start(_ navigationController: UINavigationController)
//    func moveToDetail(model: ServiceDetailModel)
    func errorAlert(completion: @escaping (() -> Void))
}
