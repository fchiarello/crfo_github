import UIKit

protocol Coordinator: AnyObject {
    func start(_ navigationController: UINavigationController)
    func moveToDetail(login: String)
    func errorAlert(completion: @escaping (() -> Void))
    func openRepoURL(urlString: String)
}
