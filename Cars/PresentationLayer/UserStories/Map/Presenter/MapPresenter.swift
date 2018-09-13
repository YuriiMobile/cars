//
//  MapPresenter.swift
//  Cars
//
//  Created by Yurii on 12.09.2018.
//  Copyright © 2018 YuriiMobile. All rights reserved.
//

import CoreLocation
import Mapbox
import PromiseKit

protocol MapPresenter: class {
    
    var mapView: MapView? { get }
    var allCarMarkersCount: Int { get }
    var activeCarMarkersCount: Int { get }
    var mapCenterCoordinate: CLLocationCoordinate2D { get }
    
    func viewDidLoad()
    func distance(_ firstCoordinate: CLLocationCoordinate2D, secondCoordinate: CLLocationCoordinate2D) -> CLLocationDistance
    func filterMarkers(from region: Region)
    func carMarker(for annotation: MGLAnnotation) -> Car?
    
}

func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
    return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
}
