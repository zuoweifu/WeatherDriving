import Foundation

class HourlyForecast: Codable {
    
    var periodDay: String
    
    var rawPeriod: String
    var period: String! {
        return rawPeriod.lowercased()
    }
    
    var weatherIcon: String
    var temperature: String
    var temperatureUnit: String
    var feelsLikeTemperature: String
    var conditionDesciption: String
    
    var wind: String
    var windUnit: String
    var windDirection: String
    
    var windGust: String
    var windGustUnit: String
    
    var popIcon: String
    var pop: String
    
    var rainValue: Double
    var rainIcon: String
    var rain: String
    
    var snowValue: Double
    var snowIcon: String?
    var snow: String
}

extension HourlyForecast {
    enum CodingKeys: String, CodingKey {
        case periodDay = "PeriodDay"
        case rawPeriod = "Period"
        
        case weatherIcon = "Icon"
        case temperature = "Temperature"
        case temperatureUnit = "TemperatureUnit"
        case feelsLikeTemperature = "FeelsLike"
        case conditionDesciption = "Condition"
        
        case wind = "WindSpeedDisplay"
        case windUnit = "WindSpeedUnit"
        case windDirection = "WindDirectionDisplay"
        
        case windGust = "WindGustDisplay"
        case windGustUnit = "WindGustUnit"
        
        case popIcon = "PopIcon"
        case pop = "Pop"
        
        case rainValue = "RainValue"
        case rainIcon = "RainIcon"
        case rain = "Rain"
        
        case snowValue = "SnowValue"
        case snowIcon = "SnowIcon"
        case snow = "Snow"
    }
}
