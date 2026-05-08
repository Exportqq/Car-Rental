import Foundation
import Combine

protocol CarsCollectionViewViewModelInputProtocol: AnyObject {
    
    func fetchCars() async throws -> [CarsModel]
}

final class CarsCollectionViewViewModel: CarsCollectionViewViewModelInputProtocol {
    
    private(set) var cars: [CarsModel] = []
    
    @Published var isLoading: Bool = false
    
    func fetchCars() async throws -> [CarsModel] {
        
        isLoading = true
        defer { isLoading = false }
        
        let result: [CarsModel] = try await ApiClient.shared.request(
            "https://car-rental-api-u04q.onrender.com/cars"
        )
        
        self.cars = result
        return result
    }
}
