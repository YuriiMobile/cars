//
//  CarsService.swift
//  Cars
//
//  Created by Yurii on 11.09.2018.
//  Copyright © 2018 YuriiMobile. All rights reserved.
//

import PromiseKit
import Mapbox

class CarsService {

    private var carsGateway: CarsGateway
    static let locationQueue: DispatchQueue = DispatchQueue(label: "com.smedialink.cars.location", qos: .userInitiated)
    
    init(carsGateway: CarsGateway = NetworkAPI()) {
        self.carsGateway = carsGateway
    }
    
    func fetchCars(withOffset offset: Int, limit: Int) -> Promise<[Car]> {
        return carsGateway.fetchCars(withOffset: offset, limit: limit)
    }
    
    func fetchCars(from region: Region) -> Promise<[Car]> {
        return carsGateway.fetchAll().map(on: CarsService.locationQueue) { cars in
            cars.filter { MGLCoordinateInCoordinateBounds(($0.coordinates ?? .zero).coordinates2D , region.bounds) }
        }
    }
    
    func fetchAll() -> Promise<[Car]> {
        return carsGateway.fetchAll()
    }
    
}
