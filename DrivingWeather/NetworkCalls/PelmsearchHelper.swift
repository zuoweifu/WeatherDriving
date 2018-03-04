import Foundation

class PelmsearchHelper {
    
    // MARK: - Static constants
    static let server : String = ""
    static let serverUrlFormat : String = ""
    static let jsonDecoder = JSONDecoder()
    
    static let timeoutSeconds : UInt64 = 20
    
    // MARK: - Public API Methods
    static func getPlacecodeForLatLong(lat: Double, long: Double) -> String {
        return getDataForLocation(lat: lat, long: long).placecode
    }
    
    // MARK: - Private methods
    
    private static func getTimeout(seconds : UInt64) -> DispatchTime {
        return DispatchTime(uptimeNanoseconds: DispatchTime.now().uptimeNanoseconds + seconds * UInt64(1e+9))
    }
    
    /// Performs the call to appframework and waits for data to return
    private static func getDataForLocation(lat: Double, long: Double) -> LocationCode {
        
        var result : LocationCode!
        let semaphore = DispatchSemaphore(value: 0)
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        let url = URL(string: String(format:serverUrlFormat, server, String(lat), String(long)))!
        let request = URLRequest(url: url)
        var success : Bool = false
        
        let task: URLSessionDataTask = session.dataTask(with: request) { (data, response, error) -> Void in
            if let data = data {
                result = parseLocationCodeFromJSON(data)
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
    
    private static func parseLocationCodeFromJSON(_ json: Data) -> LocationCode {
        var response : PelmsearchResponse!
        do {
            response = try jsonDecoder.decode(PelmsearchResponse.self, from: json)
        }
        catch {
            print(error)
            assertionFailure("An error occurred while decoding the appframework response data. It is likely a key has a typo or is missing. Check the logs for a more detailed error message.")
        }
        return response.profile[0].locations[0]
    }
}

// MARK: - Extension

extension PelmsearchHelper {
    
}

class PelmsearchResponse: Codable {
    var profile: [LocationResponse]
}

extension PelmsearchResponse {
    enum CodingKeys: String, CodingKey {
        case profile = "profile"
    }
}
