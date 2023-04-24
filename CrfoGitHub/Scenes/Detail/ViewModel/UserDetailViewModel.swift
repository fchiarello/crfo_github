import Foundation
import UIKit

protocol UserDetailViewModelProtocol: AnyObject {
    func repositoryListSuccess(model: DetailModel)
    func userImageSuccess(avatar: UIImage)
}

final class UserDetailViewModel {
    private var service: ServiceProtocol?
    
    weak var delegate: UserDetailViewModelProtocol?
    
    init(coordinator: Coordinator, service: ServiceProtocol? = nil) {
        self.service = service
    }
    
    func loadData(login: String) {
        service?.loadUserRepository(login: login, onComplete: { reposList in
            self.delegate?.repositoryListSuccess(model: reposList)
        }, onError: { error in
            print(error)
        })
    }
    
    func imageService(urlAvatar: String) {
        service?.loadImage(url: urlAvatar, onComplete: { image in
            let avatarImage = image ?? UIImage(named: Constants.avatarErrorImage)
            self.delegate?.userImageSuccess(avatar: avatarImage ?? UIImage())
        })
    }
}
