import XCTest
@testable import DrivingWeather

class WebServiceHelperTests: XCTestCase {
    
    func testWebService() {
        let eventdata = WebServiceHelper.getEventsData()
        print("------------",eventdata,"-------------")
    }
    
}
