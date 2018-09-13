//
//  MapViewController.swift
//  Cars
//
//  Created by Yurii on 11.09.2018.
//  Copyright © 2018 YuriiMobile. All rights reserved.
//

import Mapbox

protocol MapView: class {
    
    func setupMap()
    func setAnnotations(_ annotations: [MGLPointAnnotation])
    
}

extension MapView {
    
    func setAnnotations(_ annotations: [MGLPointAnnotation]) {}
    
}

class MapViewController: UIViewController {

    @IBOutlet private weak var mapView: MGLMapView!
    private lazy var presenter: MapPresenter = MapPresenterImp(mapView: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        presenter.viewDidLoad()
    }
    
    private func showMarkers() {
        presenter.filterMarkers(from: Region(bounds: mapView.visibleCoordinateBounds))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let carDescriptionController = segue.destination as? CarDescriptionViewController,
            let car = sender as? Car {
            carDescriptionController.presenter = CarDescriptionPresenterImp(car: car)
        }
    }

}

extension MapViewController: MapView {
    
    func setupMap() {
        mapView.setCenter(presenter.mapCenterCoordinate, zoomLevel: 12, animated: false)
        showMarkers()
    }
    
    func setAnnotations(_ annotations: [MGLPointAnnotation]) {
        mapView.annotations?.forEach { mapView.removeAnnotation($0) }
        mapView.addAnnotations(annotations)
    }
    
}

extension MapViewController: MGLMapViewDelegate {
    
    func mapView(_ mapView: MGLMapView, regionDidChangeWith reason: MGLCameraChangeReason, animated: Bool) {
        guard reason != .programmatic else {
            return
        }
        showMarkers()
    }
    
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        return true
    }
    
    func mapView(_ mapView: MGLMapView, didSelect annotation: MGLAnnotation) {
        guard var visibleAnnotations = mapView.annotations else {
            return
        }
        let index = visibleAnnotations.index(where: { $0.title == annotation.title && $0.subtitle == annotation.subtitle })
        guard index != nil else {
            return
        }
        
        visibleAnnotations.remove(at: index!)
        mapView.removeAnnotations(visibleAnnotations)
    }
    
    func mapView(_ mapView: MGLMapView, didDeselect annotation: MGLAnnotation) {
        showMarkers()
    }
    
    func mapView(_ mapView: MGLMapView, tapOnCalloutFor annotation: MGLAnnotation) {
        guard let carMarker = presenter.carMarker(for: annotation) else {
            return
        }
        
        
        let controller: CarDescriptionViewController = CarDescriptionViewController.instantiate()
        controller.presenter = CarDescriptionPresenterImp(car: carMarker)
        navigationController?.pushViewController(controller, animated: true)
        showMarkers()
    }
    
}
