import Foundation

class Observation: Codable {
    
    var currentWeatherIcon: String
    
    var temperature: String
    var temperatureUnit : String
    
    var feelsLikeTemperature: String
    var condition: String
    
    var windSpeed: String
    var windDirection: String
    var windSpeedUnit: String
    
    var windGust: String
    var windGustUnit: String
    
    var humidity: String
    var humidityUnit: String
    
    var pressure: String
    var pressureIcon: String
    var pressureUnit: String
    
    var visibility: String
    var visibilityUnit: String
    
    var ceiling: String
    var ceilingUnit: String
    
    var sunrise: String
    var sunset: String
    
    var yesterdayMax: String
    var yesterdayMin: String
}

extension Observation {
    enum CodingKeys: String, CodingKey {
        case currentWeatherIcon = "Icon"
        
        case temperature = "TempDisplay"
        case temperatureUnit = "TemperatureUnit"
        
        case feelsLikeTemperature = "FeelsLike"
        case condition = "Condition"
        
        case windSpeed = "WindSpeedDisplay"
        case windDirection = "WindDirectionDisplay"
        case windSpeedUnit = "WindSpeedUnit"
        
        case windGust = "WindGustDisplay"
        case windGustUnit = "WindGustUnit"
        
        case humidity = "HumidityDisplay"
        case humidityUnit = "HumidityUnit"
        
        case pressure = "PressureDisplay"
        case pressureIcon = "PressureIcon"
        case pressureUnit = "PressureUnit"
        
        case visibility = "VisibilityDisplay"
        case visibilityUnit = "VisibilityUnit"
        
        case ceiling = "CeilingDisplay"
        case ceilingUnit = "CeilingUnit"
        
        case sunrise = "Sunrise"
        case sunset = "Sunset"
        
        case yesterdayMax = "YesterdayMaxDisplay"
        case yesterdayMin = "YesterdayMinDisplay"
    }
}

