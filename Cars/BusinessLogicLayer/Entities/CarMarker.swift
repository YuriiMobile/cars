//
//  CarMarker.swift
//  Cars
//
//  Created by Yurii on 11.09.2018.
//  Copyright © 2018 YuriiMobile. All rights reserved.
//

import CoreLocation

struct CarMarker {
    
    let car: Car
    let locationCoordinate: CLLocationCoordinate2D
    
    init(_ car: Car) {
        self.car = car
        let coordinates = car.coordinates ?? .zero
        self.locationCoordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(coordinates.x),
                                                         longitude: CLLocationDegrees(coordinates.y))
    }
    
}
