import Foundation

class AlertContent: Codable {
    
    private var conditionValue: ContentObject
    private var eventTypeValue: ContentObject
    private var importanceValue: ContentObject
    private var styleValue: ContentObject
    private var typeValue: ContentObject
    
    private var iconImage: ContentObject
    private var logoImage: ContentObject?
    
    private var nameText: ContentObject
    private var messageText: ContentObject
    private var timestampText: ContentObject
    
    var condition: String? {
        return conditionValue.value
    }
    
    var eventType: String? {
        return eventTypeValue.value
    }
    
    var importance: String? {
        return importanceValue.value
    }
    
    var style: String? {
        return styleValue.value
    }
    
    var type: String? {
        return typeValue.value
    }
    
    var icon: String? {
        return iconImage.imageKey
    }
    
    var logo: String? {
        return (logoImage == nil) ? nil : logoImage!.imageKey
    }
    
    var name: String? {
        return (nameText.text == nil) ? nil : nameText.text![0]
    }
    
    var message: String? {
        return (messageText.text == nil) ? nil : messageText.text![0].trimmingCharacters(in: .whitespacesAndNewlines) + " "
    }
    
    var date: String? {
        return (timestampText.text == nil) ? nil : timestampText.text![0]
    }
}

extension AlertContent {
    enum CodingKeys: String, CodingKey {
        
        case conditionValue = "Condition"
        case eventTypeValue = "EventType"
        case importanceValue = "Importance"
        case styleValue = "Style"
        case typeValue = "Type"
        
        case iconImage = "Icon"
        case logoImage = "Logo"
        
        case nameText = "Name"
        case messageText = "Message"
        case timestampText = "Timestamp"
    }
}

