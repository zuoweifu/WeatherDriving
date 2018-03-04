import Foundation

class WebServiceHelper {
    
    // MARK: - Static constants
    static let server : String = ""
    static let serverUrlFormat : String = ""
    static let jsonDecoder = JSONDecoder()
    
    static let timeoutSeconds : UInt64 = 20
    
    // MARK: - Public API Methods
    static func getEventsData() -> [Event] {
        return getEvents()
    }
    
    static func sendEvent(event: Event) -> [Event] {
        return postEvent(event:event)
    }
    
    // MARK: - Private methods
    
    private static func getTimeout(seconds : UInt64) -> DispatchTime {
        return DispatchTime(uptimeNanoseconds: DispatchTime.now().uptimeNanoseconds + seconds * UInt64(1e+9))
    }
    
    /// Performs the call to appframework and waits for data to return
    private static func getEvents() ->[Event] {
        
        
        var result : [Event]!
        let semaphore = DispatchSemaphore(value: 0)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        let url = URL(string: String(format:serverUrlFormat, server))!
        let request = URLRequest(url: url)
        var success : Bool = false
        
        let task: URLSessionDataTask = session.dataTask(with: request) { (data, response, error) -> Void in
            if let data = data {
                result = parseEventsFromJSON(data)
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
    
    //post to db
    private static func postEvent(event: Event) ->[Event] {
        
        
        var result : [Event]!
        let semaphore = DispatchSemaphore(value: 0)
        
        let url = URL(string: String(format:serverUrlFormat, server))!
        var request = URLRequest(url: url)
        request.setValue("text/plain", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        var success : Bool = false
        
        let jsonEncoder = JSONEncoder()
        var postString = ""
        do {
        let stringData = try jsonEncoder.encode(event)
            postString = String(data: stringData, encoding: String.Encoding.utf8) as String!
            print("-----------------------------")
            print(postString)
            print("-----------------------------")
        }
        catch {
            
        }
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                success = false
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
                success = false
            }
            else {
                success = true
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
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
    
    private static func parseEventsFromJSON(_ json: Data) -> [Event] {
        var response : [Event]!
        do {
            response = try jsonDecoder.decode([Event].self, from: json)
        }
        catch {
            print(error)
            assertionFailure("An error occurred while decoding the appframework response data. It is likely a key has a typo or is missing. Check the logs for a more detailed error message.")
        }
        return response
    }
}

// MARK: - Extension

extension PelmsearchHelper {
    
}

