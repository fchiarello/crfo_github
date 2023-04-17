import Foundation
import UIKit

protocol UsersViewModelDelegate {
    func successList()
    func errorList()
}

final class UsersViewModel {
    private var service: ServiceProtocol?
    
    var usersList: Model?
    var avatar: UIImage?
    
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
        service?.loadImage(url: urlAvatar, onComplete: { image in
            self.avatar = image
        })
        return self.avatar ?? UIImage()
    }
}
