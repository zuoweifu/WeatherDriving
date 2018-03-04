import Foundation

class LocationResponse: Codable {
    var locations: [LocationCode]
}

extension LocationResponse {
    enum CodingKeys: String, CodingKey {
        case locations = "location"
    }
}

