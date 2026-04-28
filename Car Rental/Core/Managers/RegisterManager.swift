import Foundation

final class RegisterManager {

    static let shared = RegisterManager()

    func register(
        username: String,
        password: String
    ) async throws -> LoginResponse {

        let body: [String: Any] = [
            "username": username,
            "password": password
        ]

        let response: LoginResponse = try await ApiClient.shared.request(
            "\(APIConstants.baseURL)/auth/register",
            method: .post,
            body: body
        )

        KeychainService.shared.saveToken(response.token)
        return response
    }
}
