import Foundation

protocol BrandsCollectionViewViewModelInputProtocol: AnyObject {
    
    func fetchBrands() async throws -> [BrandsModel]
}

final class BrandsCollectionViewViewModel: BrandsCollectionViewViewModelInputProtocol {
    
    private(set) var brands: [BrandsModel] = []
    private(set) var filteredPlaces: [BrandsModel] = []
    
    func fetchBrands() async throws -> [BrandsModel] {
        let result: [BrandsModel] = try await ApiClient.shared.request(
            "https://car-rental-api-u04q.onrender.com/brands"
        )
        
        self.brands = result
        return result
    }
}
