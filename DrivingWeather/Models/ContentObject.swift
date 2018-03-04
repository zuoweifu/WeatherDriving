import Foundation

class ContentObject: Codable {
    
    var text: [String]?
    var value: String?
    var imageKey: String?
}

extension ContentObject {
    enum CodingKeys: String, CodingKey {
        case text = "Text"
        case value = "Value"
        case imageKey = "ImageKey"
    }
}

