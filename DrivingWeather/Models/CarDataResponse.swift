import Foundation

public struct CarDataResponse: Codable {
    
    var carData: [CarData]
    
}

extension CarDataResponse {
    enum CodingKeys: String, CodingKey {
        case carData = "cars"
    }
}


