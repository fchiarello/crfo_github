import Foundation
import UIKit

protocol UsersViewModelDelegate {
    func successList()
    func errorList()
}

final class UsersViewModel {
    private var service: ServiceProtocol?
    
    var usersList: Model?
    
    var delegate: UsersViewModelDelegate?
    
    init(coordinator: Coordinator, service: ServiceProtocol? = nil) {
        self.service = service
    }
    
    func loadServices() {
        service?.loadGitHubServices(url: Constants.allUsersUrl, onComplete: { users in
            self.usersList = users
            print(users)
        }, onError: { error in
            print(error)
        })
    }
    
    func imageService(urlAvatar: String) -> UIImage {
        var image: UIImage?
        
        if let url = URL(string: urlAvatar) {
            do {
                let path = try Data(contentsOf: url)
                image = UIImage(data: path)
            } catch {
                image = UIImage(systemName: Constants.avatarErrorImage)
            }
        } else {
            image = UIImage(systemName: Constants.avatarErrorImage)
        }
        return image ?? UIImage()
    }
}
