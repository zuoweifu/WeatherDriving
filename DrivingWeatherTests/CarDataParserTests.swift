import XCTest
@testable import DrivingWeather

class CarDataParserTests: XCTestCase {
    func testgettingCarData() {
        let cardata = CarDataHelper.parseCarDataFromJSON()
        XCTAssertGreaterThan(cardata.carData.count, 0)
    }
}

class CarDataTests: XCTestCase {
    func testCarModel() {
        var car: CarData
        car = CarDataHelper.getCarData(index: 1)
        print("---------------" , car , "---------------")
    }
}


class EventWeightFunctionTests: XCTestCase {
    func testEventWeight() {
        var car: CarData
        car = CarDataHelper.getCarData(index: 0)
        
        var placecode: String
        placecode = PelmsearchHelper.getPlacecodeForLatLong(lat: car.lat,long: car.long)
        
        var obs: Observation
        obs = AppFrameworkHelper.getObservationDataForLocation(placeCode: placecode)!
        
        var visibilityEvent: Event? = EventGenerator.hasVisibilityEvent(car: car , obs: obs)
        print("------------",visibilityEvent,"---------------")
        
        WebServiceHelper.sendEvent(event: visibilityEvent!)
    }
}
