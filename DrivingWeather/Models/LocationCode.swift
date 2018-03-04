import Foundation

class LocationCode: Codable {
    var placecode: String
}

extension LocationCode {
    enum CodingKeys: String, CodingKey {
        case placecode = "code"
    }
}
