import Foundation

struct BrandsModel: Decodable {
    let id: Int
    let name: String?
    let image: String?
    let count: Int

    enum CodingKeys: String, CodingKey {
        case id, name, image ,count
    }
}
