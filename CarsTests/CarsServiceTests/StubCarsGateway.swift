//
//  StubCarsGateway.swift
//  CarsTests
//
//  Created by Yurii on 13.09.2018.
//  Copyright © 2018 YuriiMobile. All rights reserved.
//

import PromiseKit
@testable import Cars

class StubCarsGateway: CarsGateway {
    
    private let cars: [Car]
    
    init(cars: [Car]) {
        self.cars = cars
    }
    
    func fetchAll() -> Promise<[Car]> {
        return Promise.value(cars)
    }
    
    func fetchCars(withOffset offset: Int, limit: Int) -> Promise<[Car]> {
        let startIndex = offset
        let endIndex = min(offset + limit, cars.count)
        let fetchedCars = Array(cars[startIndex..<endIndex])
        
        return Promise.value(fetchedCars)
    }
    
}
