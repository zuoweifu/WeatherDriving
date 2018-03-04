//
//  DrivingWeatherTests.swift
//  DrivingWeatherTests
//
//  Created by Alex St George on 2018-01-26.
//  Copyright © 2018 Pelmorex Media Inc. All rights reserved.
//

import XCTest
@testable import DrivingWeather

class AppFrameworkTests: XCTestCase {
    
    var placeCode = "CAQC0996"
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetObservationData() {
        let obs = AppFrameworkHelper.getObservationDataForLocation(placeCode: placeCode)
        XCTAssertNotNil(obs)
        XCTAssertEqual(obs?.temperature, "-12")
    }
    
    func testGetHourlyForecast() {
        let hourlyForecast = AppFrameworkHelper.getHourlyForecastDataForLocation(placeCode: placeCode)
        XCTAssertNotNil(hourlyForecast)
        XCTAssertEqual(hourlyForecast?.count, 36)
    }
    
    func testGetShortTermForecast() {
        let shortTerm = AppFrameworkHelper.getShortTermForecastDataForLocation(placeCode: placeCode)
        XCTAssertNotNil(shortTerm)
        XCTAssertEqual(shortTerm?.count, 6)
    }
    
    func testGetAlerts() {
        let alerts = AppFrameworkHelper.getAlertsForLocation(placeCode: placeCode)
        XCTAssertNotNil(alerts)
        XCTAssertEqual(alerts?.count, 3)
    }
    
    func testGetPSSData() {
        let pss = AppFrameworkHelper.getPSSForLocation(placeCode: placeCode)
        XCTAssertNotNil(pss)
        XCTAssertGreaterThan((pss?.pssDataPointDescriptions.count)!, 0)
    }
    
}
