//
//  CarDescriptionPresenterTests.swift
//  CarsTests
//
//  Created by Yurii on 13.09.2018.
//  Copyright © 2018 YuriiMobile. All rights reserved.
//

import XCTest
@testable import Cars

class CarDescriptionPresenterTests: XCTestCase {

    private var presenter: CarDescriptionPresenterImp!
    
    override func setUp() {
        super.setUp()
        
        let car = Car(vin: "123", name: "123")
        presenter = CarDescriptionPresenterImp(car: car)
    }
    
    func testFetchValidDescription() {
        let descriptin = presenter.description(at: 0)
        
        XCTAssertNotNil(descriptin)
    }
    
    func testFetchInvalidDescription() {
        let descriptin = presenter.description(at: 10)
        
        XCTAssertNil(descriptin)
    }
    
}
