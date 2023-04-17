import Foundation

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
}
