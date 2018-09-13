//
//  MapPresenterTests.swift
//  CarsTests
//
//  Created by Yurii on 13.09.2018.
//  Copyright © 2018 YuriiMobile. All rights reserved.
//

import XCTest
@testable import Cars

class MapPresenterTests: XCTestCase {

    private var fetchExpectation: XCTestExpectation?
    
    override func setUp() {
        super.setUp()
        
        fetchExpectation = nil
    }
    
    func testLoadCarMarkers() {
        let carsCount = 10
        let gateway = StubCarsGateway(cars: [Car].init(repeating: Car(vin: "123", name: "123"), count: carsCount))
        let service = CarsService(carsGateway: gateway)
        let presenter = MapPresenterImp(mapView: self, carsService: service)
        
        fetchExpectation = self.expectation(description: "fetchMarkers")
        presenter.viewDidLoad()
        waitForExpectations(timeout: 2, handler: nil)
        
        XCTAssertTrue(presenter.allCarMarkersCount == carsCount, "Actual count = \(presenter.allCarMarkersCount)")
    }
    
}

extension MapPresenterTests: MapView {
    
    func setupMap() {
        fetchExpectation?.fulfill()
    }
    
}
