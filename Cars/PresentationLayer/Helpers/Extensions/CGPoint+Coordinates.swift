//
//  CGPoint+Coordinates.swift
//  Cars
//
//  Created by Yurii on 13.09.2018.
//  Copyright © 2018 YuriiMobile. All rights reserved.
//

import UIKit
import CoreLocation

extension CGPoint {
    
    var coordinates2D: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: CLLocationDegrees(x), longitude: CLLocationDegrees(y))
    }
    
}
