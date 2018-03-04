import Foundation

class CarDataHelper {
    
    static let jsonDecoder = JSONDecoder()
    
    static func parseCarDataFromJSON() -> CarDataResponse {
        
        var response: CarDataResponse!
        
        if let path = Bundle.main.path(forResource: "mockdata", ofType: "json")
        {
            do {
                let jsonData = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                response = try jsonDecoder.decode(CarDataResponse.self, from: jsonData)
            }
            catch {
                print(error)
                assertionFailure("An error occurred while decoding the car data response data. It is likely a key has a typo or is missing. Check the logs for a more detailed error message.")
            }
        }
        else{
            assertionFailure("Failed to get resource")
        }
   
        return response
    }
    
    static func getCarData(index:Int) -> CarData {
        let cardata = CarDataHelper.parseCarDataFromJSON()
        return cardata.carData[index]
    }
}


