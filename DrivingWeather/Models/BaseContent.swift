import Foundation

class BaseContent: Codable {
    
    var thumbnail: ContentThumbnail?
    private var titleText: ContentObject
    
    var title: String? {
        return (titleText.text == nil) ? "" : titleText.text![0]
    }
}

extension BaseContent {
    enum CodingKeys: String, CodingKey {
        case thumbnail = "ThumbNail"
        case titleText = "Title"
    }
}
