import Foundation

enum ErrorType {
    case urlError
    case jsonError
    case statusCodeError(code: Int)
    case taskError(error: Error)
}

protocol ServiceProtocol {
    func loadGitHubServices(url: String,
                           onComplete: @escaping (UsersModel) -> Void,
                           onError: @escaping (ErrorType) -> Void)
}

final class Service: ServiceProtocol {
    func loadGitHubServices(url: String, onComplete: @escaping (UsersModel) -> Void, onError: @escaping (ErrorType) -> Void) {
        print("NICE!!!")
    }
}
