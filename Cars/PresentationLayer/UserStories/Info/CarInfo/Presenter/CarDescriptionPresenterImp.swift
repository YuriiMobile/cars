//
//  CarDescriptionPresenterImp.swift
//  Cars
//
//  Created by Yurii on 11.09.2018.
//  Copyright © 2018 YuriiMobile. All rights reserved.
//

import UIKit

class CarDescriptionPresenterImp: CarDescriptionPresenter {
    
    private let car: Car
    private let carDescriptions: [CarFieldDescriptor]
    
    var fieldCount: Int {
        return carDescriptions.count
    }
    
    required init(car: Car) {
        self.car = car
        
        let defaultValue = "undefined"
        let coordinates = car.coordinates ?? .zero
        self.carDescriptions = [
            CarFieldDescriptor(fieldType: .vin, value: car.vin ?? defaultValue),
            CarFieldDescriptor(fieldType: .name, value: car.name ?? defaultValue),
            CarFieldDescriptor(fieldType: .address, value: car.address ?? defaultValue  ),
            CarFieldDescriptor(fieldType: .coordinates, value: "\(coordinates.x), \(coordinates.y)"),
            CarFieldDescriptor(fieldType: .engineType, value: car.engineType?.rawValue ?? defaultValue),
            CarFieldDescriptor(fieldType: .exteriorLevel, value: car.exteriorLevel?.rawValue ?? defaultValue),
            CarFieldDescriptor(fieldType: .interiorLevel, value: car.interiorLevel?.rawValue ?? defaultValue),
            CarFieldDescriptor(fieldType: .fuel, value: String(car.fuel ?? 0))
        ]
    }
    
    func description(at index: Int) -> CarFieldDescriptor? {
        guard carDescriptions.isValid(index: index) else {
            return nil
        }
        
        return carDescriptions[index]
    }

}
