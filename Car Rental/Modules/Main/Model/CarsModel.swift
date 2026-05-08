import Foundation

struct CarsModel: Decodable {
    let id: Int
    let name: String?
    let brand: String?
    let brand_image: String?
    let transmission: String?
    let seats: Int
    let fuel_type: String?
    let car_image: String?
    let rating: Double?
    let reviews_count: String?
    let horsepower: String?
    let max_speed: String?
    let characteristics: String?
    let price_per_hour: Int
    let price_per_day: Int
    let location: String?
    let lat: Double
    let lng: Double
    let is_favorite: Bool
}

