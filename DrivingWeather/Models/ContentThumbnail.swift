import Foundation

class ContentThumbnail: Codable {
    
    var duration: Double
    var type: String?
    var url: String
}

extension ContentThumbnail {
    enum CodingKeys: String, CodingKey {
        case duration = "Duration"
        case type = "Type"
        case url = "Url"
    }
}
