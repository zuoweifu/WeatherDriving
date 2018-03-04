import XCTest
@testable import DrivingWeather

class PelmsearchHelperTests: XCTestCase {
    
    //http://pelmsearch.pelmorex.com/api/appframework/search/GetFollowMe?locale=en-CA&lat=48.427591&long=-71.061108
    
    func testGetPlacecode() {
        let lat = 48.521135
        let long = -71.192697
        let expectedPlacecode = "CAQC0996"
        let placecode = PelmsearchHelper.getPlacecodeForLatLong(lat: lat, long: long)
        XCTAssertEqual(placecode, expectedPlacecode)
    }
}

