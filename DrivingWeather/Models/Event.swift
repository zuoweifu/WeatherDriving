import Foundation

//{"lat":43.508813,"long":-79.687550,"eventtime":"2018-01-27T12:00:00.123Z","eventtype":0,"cause":"Ice Fog","severity":2,"rank2":10,"notes":"Generated by car"}

class Event: Codable {
    var EventType: EventTypes!
    var Severity: EventSeverity!
    var Lat: Double!
    var Long: Double!
    var Cause: String?
    var Notes: String?
    var Time: String!
    

}

extension Event {
    enum EventTypes: Int, Codable {
        case Visibility
        case RoadCondition
        case Extreme
    }
    
    enum EventSeverity: Int, Codable {
        case Low
        case Medium
        case High
    }
    
    
        enum CodingKeys: String, CodingKey {
            case EventType = "eventtype"
            case Severity = "severity"
            case Lat = "lat"
            case Long = "long"
            case Cause = "cause"
            case Notes = "notes"
            case Time = "eventtime"
        }
    
}