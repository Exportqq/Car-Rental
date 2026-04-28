import Foundation
import Combine

protocol ProfileViewModelInputProtocol: AnyObject {
    var user: ProfileModel? { get }
    var userPublisher: Published<ProfileModel?>.Publisher { get }
    
    func fetchProfile() async throws -> ProfileModel
}

final class ProfileViewModel: ProfileViewModelInputProtocol {

    @Published private(set) var user: ProfileModel?
    @Published var isLoading: Bool = false

    
    var userPublisher: Published<ProfileModel?>.Publisher { $user }

    func fetchProfile() async throws -> ProfileModel {
        
        isLoading = true
        defer { isLoading = false }
        
//        try await Task.sleep(nanoseconds: 5_000_000_000) слип для проверки работы лоадера
        
        let result: ProfileModel = try await ApiClient.shared.request(
            "\(APIConstants.baseURL)/profile",
            method: .get
        )

        self.user = result
        return result
    }
}
