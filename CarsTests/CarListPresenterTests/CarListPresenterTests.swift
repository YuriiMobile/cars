//
//  CarListPresenterTests.swift
//  CarsTests
//
//  Created by Yurii on 11.09.2018.
//  Copyright © 2018 YuriiMobile. All rights reserved.
//

import XCTest
import PromiseKit
@testable import Cars

class CarListPresenterTests: XCTestCase {
    
    private var inserIndexes: InsertIndexes?
    
    override func setUp() {
        super.setUp()
        
        inserIndexes = nil
    }
    
    func testCarNameEmptyStorage() {
        let presenter = CarListPresenterImp()
        let name = presenter.carName(at: 0)
        
        XCTAssertEqual("undefined", name, "Actual name is \(name)")
    }
    
    func testCarNameValidName() {
        let cars = [Car(vin: "1233", name: "BMW"),
                    Car(vin: "1234", name: "Lada"),
                    Car(vin: "1235", name: "Pego"),
                    Car(vin: "1236", name: "Mercedec")]
        
        let presenter = CarListPresenterImp(carsList: cars)
        let name = presenter.carName(at: 2)
        
        XCTAssertEqual("Pego", name, "Actual name is \(name)")
    }
    
    func testFetchValid() {
        let carsCount = 100
        let cars = createCars(count: carsCount)
        let service = createCarsService(cars: cars)
        let presenter = CarListPresenterImp(carsService: service, carsListView: self, carsList: Array(cars[0...49]))
        
        let expectation = self.expectation(description: "fetchFirst")
        presenter.attemptFetchNextPage(currentRowIndex: 50)
    
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 3, handler: nil)
        let expectIndexes: InsertIndexes = (startIndex: 0, endIndex: 49)
        XCTAssertEqual(expectIndexes.startIndex, inserIndexes!.startIndex, "Insert start index = \(inserIndexes!.startIndex)")
        XCTAssertEqual(expectIndexes.endIndex, inserIndexes!.endIndex, "Insert end index = \(inserIndexes!.endIndex)")
    }
    
    func testFetchEmpty() {
        let carsCount = 50
        let cars = createCars(count: carsCount)
        let service = createCarsService(cars: cars)
        let fetchHelper = FetchHelper()
        fetchHelper.endFetching(resultsCount: carsCount)
        let presenter = CarListPresenterImp(carsService: service, fetchHelper: fetchHelper, carsListView: self)
        
        let expectation = self.expectation(description: "fetch")
        presenter.attemptFetchNextPage(currentRowIndex: 50)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 3, handler: nil)
        XCTAssertNil(inserIndexes)
    }
    
    private func createCars(count: Int) -> [Car] {
        return [Car].init(repeating: Car(vin: "123", name: "sdf"), count: count)
    }
    
    private func createCarsService(cars: [Car]) -> CarsService {
        let stubGateway = StubCarsGateway(cars: cars)
        
        return CarsService(carsGateway: stubGateway)
    }
    
}

extension CarListPresenterTests: CarsListView {
    
    func reloadData() {}
    
    func insertCells(at indexes: InsertIndexes?) {
        inserIndexes = indexes
    }
    
}
