import Foundation

final class SessionManager {

    static let shared = SessionManager()
    private init() {}

    var isAuthorized: Bool {
        KeychainService.shared.getToken() != nil
    }

    func logout() {
        KeychainService.shared.deleteToken()
    }
}
