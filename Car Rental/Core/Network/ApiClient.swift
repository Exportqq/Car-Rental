import Foundation

enum HTTPContentType {
    case json
    case formURLEncoded
}

final class ApiClient {

    static let shared = ApiClient()
    private init() {}

    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
//        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()

    func request<T: Decodable>(
        _ endpoint: String,
        method: HTTPMethod = .get,
        body: [String: Any]? = nil,
        token: String? = nil,
        contentType: HTTPContentType = .json
    ) async throws -> T {

        guard let url = URL(string: endpoint) else {
            throw APIError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        switch contentType {
        case .json:
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            if let body {
                request.httpBody = try JSONSerialization.data(withJSONObject: body)
            }
        case .formURLEncoded:
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            if let body {
                let formString = body.map { "\($0.key)=\("\($0.value)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")" }
                                     .joined(separator: "&")
                request.httpBody = formString.data(using: .utf8)
            }
        }

        let finalToken = token ?? KeychainService.shared.getToken()

        if let finalToken {
            request.setValue("Bearer \(finalToken)", forHTTPHeaderField: "Authorization")
        }

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let http = response as? HTTPURLResponse else {
            throw APIError.unknown
        }

        if http.statusCode == 401 {
            throw APIError.unauthorized
        }

        guard (200...299).contains(http.statusCode) else {
            throw APIError.server(http.statusCode)
        }

        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw APIError.decoding
        }
    }
}
