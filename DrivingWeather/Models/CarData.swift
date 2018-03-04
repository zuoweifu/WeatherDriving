import Foundation

public struct CarData: Codable {
    
    var key: Int
    var lat: Double
    var long: Double
    var externaltemp: Double
    var speed: Double
    var tirepressure: Double
    var wiper: String
    var fuellevel: Double
    var rpm: Double
    var headlampstatus: String
    var wiperfreq: Double
    
}

extension CarData {
    enum CodingKeys: String, CodingKey {
        case key = "key"
        case lat = "Lat"
        case long = "Long"
        case externaltemp = "Externaltemp"
        case speed = "Speed"
        case tirepressure = "TirePressure"
        case wiper = "Wiper"
        case fuellevel = "FuelLevel"
        case rpm = "RPM"
        case headlampstatus = "Headlampstatus"
        case wiperfreq = "WiperFreq"
    }
}

