import Foundation

class AppFrameworkHelper {
    
    // MARK: - Static constants
    static let qa2Server : String = "http://framework-qa02.dqs.pelmorex.com"
    static let serverUrlFormat : String = "%@/api/appframework/WeatherData/getData/iPhone?location=%@&dataType=%@&deviceLang=en-CA&tempUnit=C&measurementUnit=metric&appVersion=4.0.0.965"
    static let jsonDecoder = JSONDecoder()
    
    static let timeoutSeconds : UInt64 = 20
    
    // MARK: - Public API Methods
    static func getObservationDataForLocation(placeCode: String) -> Observation? {
        return getDataForLocation(placeCode: placeCode, dataType: .observation)
    }
    
    static func getHourlyForecastDataForLocation(placeCode: String) -> [HourlyForecast]? {
        return getDataForLocation(placeCode: placeCode, dataType: .hourly)
    }
    
    static func getShortTermForecastDataForLocation(placeCode: String) -> [ShortTermForecast]? {
        return getDataForLocation(placeCode: placeCode, dataType: .shortTerm)
    }
    
    static func getAlertsForLocation(placeCode: String) -> [AlertContent]? {
        return getDataForLocation(placeCode: placeCode, dataType: .alerts)
    }
    
    static func getPSSForLocation(placeCode: String) -> PSSContent? {
        return getDataForLocation(placeCode: placeCode, dataType: .pss)
    }
    
    // MARK: - Private methods
    
    private static func getTimeout(seconds : UInt64) -> DispatchTime {
        return DispatchTime(uptimeNanoseconds: DispatchTime.now().uptimeNanoseconds + seconds * UInt64(1e+9))
    }
    
    /// Performs the call to appframework and waits for data to return
    private static func getDataForLocation<T>(placeCode: String, dataType: DataTypes) -> T? {
        
        var result : T?
        let semaphore = DispatchSemaphore(value: 0)
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let dataTypeForURL = getDataTypeDescription(dataType)
        
        let url = URL(string: String(format:serverUrlFormat, qa2Server, placeCode, dataTypeForURL))!
        let request = URLRequest(url: url)
        var success : Bool = false
        
        let task: URLSessionDataTask = session.dataTask(with: request) { (data, response, error) -> Void in
            if let data = data {
                result = parseFromJSON(dataType: dataType, json: data)
                success = true
            } else {
                success = false
            }
            
            semaphore.signal()
        }
        task.resume()
        let finishedBeforeTimeout = semaphore.wait(timeout: getTimeout(seconds: timeoutSeconds))
        switch (finishedBeforeTimeout) {
        case .success:
            if (!success) {
                assertionFailure("An error occurred getting data from the call to [\(url.absoluteString)]")
            }
            return result
        case .timedOut:
            assertionFailure("The operation timed out when attempting to call [\(url.absoluteString)]")
        }
        return result
    }
    
    private static func parseFromJSON<T>(dataType: DataTypes, json: Data) -> T? {
        switch dataType {
        case .observation:
            return parseObservationFromJSON(json) as? T
        case .hourly:
            return parseHourlyForecastFromJSON(json) as? T
        case .shortTerm:
            return parseShortTermForecastFromJSON(json) as? T
        case .alerts:
            return parseAlertsFromJSON(json) as? T
        case .pss:
            return parsePSSFromJSON(json) as? T
        }
    }
    
    private static func getEndpointFromDataType(_ dataType: DataTypes) -> Endpoints {
        switch dataType {
        case .observation:
            return .weatherData
        case .hourly:
            return .weatherData
        case .shortTerm:
            return .weatherData
        case .alerts:
            return .weatherData
        case .pss:
            return .weatherData
        }
    }
    
    private static func getDataTypeDescription(_ dataType: DataTypes) -> String {
        switch dataType {
        case .observation:
            return "Observation"
        case .hourly:
            return "Hourly"
        case .shortTerm:
            return "ShortTerm"
        case .alerts:
            return "Alerts"
        case .pss:
            return "PSSRSSChart"
        }
    }
    
    private static func parseAppFrameworkResponseFromJSON(_ json: Data) -> AppFrameworkResponse {
        var response : AppFrameworkResponse!
        do {
            response = try jsonDecoder.decode(AppFrameworkResponse.self, from: json)
        }
        catch {
            print(error)
            assertionFailure("An error occurred while decoding the appframework response data. It is likely a key has a typo or is missing. Check the logs for a more detailed error message.")
        }
        return response
    }
    
    private static func parseObservationFromJSON(_ json: Data) -> Observation? {
        let response = parseAppFrameworkResponseFromJSON(json)
        if (response.observation == nil) {
            assertionFailure("Unable to retrieve observation data from appframework response.")
        }
        return response.observation!
    }
    
    private static func parseHourlyForecastFromJSON(_ json: Data) -> [HourlyForecast] {
        let response = parseAppFrameworkResponseFromJSON(json)
        if (response.hourlyForecast == nil) {
            assertionFailure("Unable to retrieve hourly forecast from appframework response.")
        }
        return response.hourlyForecast!.forecasts
    }
    
    private static func parseShortTermForecastFromJSON(_ json: Data) -> [ShortTermForecast] {
        let response = parseAppFrameworkResponseFromJSON(json)
        if (response.shortTermForecast == nil) {
            assertionFailure("Unable to retrieve short term forecast from appframework response.")
        }
        return response.shortTermForecast!.forecasts
    }
    
    private static func parseAlertsFromJSON(_ json: Data) -> [AlertContent]? {
        let response = parseAppFrameworkResponseFromJSON(json)
        if (response.alertsResponse == nil) {
            assertionFailure("Unable to retrieve alerts content from appframework response.")
        }
        return response.alertsResponse!.alertContents
    }
    
    private static func parsePSSFromJSON(_ json: Data) -> PSSContent? {
        let response = parseAppFrameworkResponseFromJSON(json)
        if (response.pssResponse == nil) {
            assertionFailure("Unable to retrieve PSS data from appframework response.")
        }
        return response.pssResponse
    }
}

// MARK: - Extension

extension AppFrameworkHelper {
    enum DataTypes {
        case observation
        case hourly
        case shortTerm
        case alerts
        case pss
    }
    
    enum Endpoints {
        case data
        case weatherData
    }
}

// MARK: - Helper models

class AppFrameworkResponse: Codable {
    var observation: Observation?
    var hourlyForecast: HourlyForecastResponse?
    var shortTermForecast: ShortTermForecastResponse?
    var alertsResponse: AlertsResponse?
    var pssResponse: PSSContent?
}

extension AppFrameworkResponse {
    enum CodingKeys: String, CodingKey {
        case observation = "Observation"
        case hourlyForecast = "Hourly"
        case shortTermForecast = "ShortTerm"
        case alertsResponse = "Alerts"
        case pssResponse = "PSSRSSChart"
    }
}

class HourlyForecastResponse: Codable {
    var forecasts: [HourlyForecast]
}

extension HourlyForecastResponse {
    enum CodingKeys: String, CodingKey {
        case forecasts = "Hourlies"
    }
}

class ShortTermForecastResponse: Codable {
    var forecasts: [ShortTermForecast]
}

extension ShortTermForecastResponse {
    enum CodingKeys: String, CodingKey {
        case forecasts = "ShortTerms"
    }
}

class AlertsResponse: Codable {
    var alertContents: [AlertContent]?
}

extension AlertsResponse {
    enum CodingKeys: String, CodingKey {
        case alertContents = "array"
    }
}

