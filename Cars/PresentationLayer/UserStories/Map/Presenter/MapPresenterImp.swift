//
//  MapPresenterImp.swift
//  Cars
//
//  Created by Yurii on 12.09.2018.
//  Copyright © 2018 YuriiMobile. All rights reserved.
//

import UIKit
import CoreLocation
import Mapbox
import PromiseKit

class MapPresenterImp: MapPresenter {

    private(set) weak var mapView: MapView?
    private lazy var activeCarMarkers: [Car] = []
    private lazy var carMarkers: [Car] = []
    private let carsService: CarsService
    
    var allCarMarkersCount: Int {
        return carMarkers.count
    }
    var activeCarMarkersCount: Int {
        return activeCarMarkers.count
    }
    
    var mapCenterCoordinate: CLLocationCoordinate2D {
        return carMarkers.first?.coordinates?.coordinates2D ?? CLLocationCoordinate2D()
    }
    
    init(mapView: MapView, carsService: CarsService = CarsService()) {
        self.mapView = mapView
        self.carsService = carsService
    }
    
    func viewDidLoad() {
        firstly {
            loadCars()
        }.done(on: .main) { _ in
            self.mapView?.setupMap()
        }.catch { error in
            print(error)
        }
    }
    
    private func loadCars() -> Promise<Void> {
        return firstly {
            carsService.fetchAll()
        }.map { cars in
            self.carMarkers = cars
        }.asVoid()
    }
    
    func distance(_ firstCoordinate: CLLocationCoordinate2D, secondCoordinate: CLLocationCoordinate2D) -> CLLocationDistance {
        let firstLocation = CLLocation(latitude: firstCoordinate.latitude, longitude: firstCoordinate.longitude)
        let secondLocation = CLLocation(latitude: secondCoordinate.latitude, longitude: secondCoordinate.longitude)
        
        return firstLocation.distance(from: secondLocation)
    }
    
    func filterMarkers(from region: Region) {
        firstly {
            carsService.fetchCars(from: region)
        }.then(on: CarsService.locationQueue) { cars in
            self.annotations(for: cars)
        }.done(on: .main) { annotations in
            self.mapView?.setAnnotations(annotations)
        }.catch { _ in }
    }
    
    private func annotations(for cars: [Car]) -> Guarantee<[MGLPointAnnotation]> {
        let annotations = cars.map { car -> MGLPointAnnotation in
            let annotation = MGLPointAnnotation()
            annotation.coordinate = (car.coordinates ?? .zero).coordinates2D
            annotation.title = car.address
            annotation.subtitle = car.vin
            
            return annotation
        }
        
        activeCarMarkers = cars
        
        return Guarantee<[MGLPointAnnotation]>.value(annotations)
    }
    
    func carMarker(for annotation: MGLAnnotation) -> Car? {
        return activeCarMarkers.first(where: { ($0.coordinates ?? .zero).coordinates2D == annotation.coordinate && $0.vin == annotation.subtitle })
    }
    
}
