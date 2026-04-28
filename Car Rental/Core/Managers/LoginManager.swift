import Foundation

final class LoginManager {

    static let shared = LoginManager()

    func login(
        username: String,
        password: String
    ) async throws -> LoginResponse {

        let body: [String: Any] = [
            "username": username,
            "password": password
        ]

        let response: LoginResponse = try await ApiClient.shared.request(
            "\(APIConstants.baseURL)/auth/login",
            method: .post,
            body: body
        )

        return response
    }
}
