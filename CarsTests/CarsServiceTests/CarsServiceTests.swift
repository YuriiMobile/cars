//
//  CarsServiceTests.swift
//  CarsTests
//
//  Created by Yurii on 11.09.2018.
//  Copyright © 2018 YuriiMobile. All rights reserved.
//

import XCTest
import PromiseKit
@testable import Cars

class CarsServiceTests: XCTestCase {
    
    private var service: CarsService!
    private let allCount = 50
    
    override func setUp() {
        super.setUp()
        
        let cars = [Car].init(repeating: Car(vin: "123", name: "sdf"), count: allCount)
        let stubGateway = StubCarsGateway(cars: cars)
        service = CarsService(carsGateway: stubGateway)
    }
    
    func testFetchValid() {
        let expectation = self.expectation(description: "fetchAll")
        var carsCount = 0
        firstly {
            service.fetchAll()
            }.done { (cars) in
                carsCount = cars.count
                expectation.fulfill()
            }.catch {_ in
                expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertTrue(carsCount == allCount, "Actual count = \(carsCount)")
    }
    
    func testFetchEmpty() {
        let expectation = self.expectation(description: "fetchEmpty")
        var carsCount = 0
        firstly {
            service.fetchCars(withOffset: 50, limit: 50)
            }.done { (cars) in
                carsCount = cars.count
                expectation.fulfill()
            }.catch {_ in
                expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertTrue(carsCount == 0, "Actual count = \(carsCount)")
    }
    
}
