//
//  FMViewController+Map.swift
//  car2go_sample
//
//  Created by Jonghyun Kim on 2017/06/14.
//  Copyright © 2017 kokaru. All rights reserved.
//

import MapKit
import SVPulsingAnnotationView

extension FMViewController : MKMapViewDelegate {
    
    func initializeMap() {
        self.mapView.tintColor = Const.FMThemeColor
        self.mapView.showsUserLocation = true
    }
    
    func addAnnotation(array: [Vehicle]) {
        
        self.clearRoute()
        self.mapView .removeAnnotations(self.mapView.annotations)
        self.addCurrentAnnotation()
        var arrayForSort : [Vehicle] = [Vehicle]()
        for vehicle in array {
            let annotation : FMAnnotation = FMAnnotation()
            annotation.coordinate = CLLocationCoordinate2DMake(vehicle.latitude!, vehicle.longitude!)
            annotation.title = vehicle.name
            vehicle.distance = CLLocation(latitude: self.mapView.userLocation.coordinate.latitude, longitude: self.mapView.userLocation.coordinate.longitude).distance(from: CLLocation(latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude))
            annotation.vehicle = vehicle
            self.mapView.addAnnotation(annotation)
            arrayForSort.append(vehicle)
        }
        
        arrayForSort = arrayForSort.sorted(by: { $0.distance! < $1.distance! })
        self.arrayVehicles = arrayForSort
        for (idx, vehicle) in arrayForSort.enumerated(){
            vehicle.index = idx+1
        }
        self.updateTableView(array: self.arrayVehicles)
    }
        
    func addCurrentAnnotation() {
        self.mapView.removeAnnotation(self.mapView.userLocation)
        let currrentAnnotation = FMAnnotationCurrent()
        currrentAnnotation.coordinate = self.mapView.userLocation.coordinate
        self.mapView.addAnnotation(currrentAnnotation)
    }
    
    func clearRoute() {
        if let route = self.routeDetails {
            self.mapView.remove(route.polyline)
            self.mapView.setNeedsLayout()
            self.mapView.layer.setNeedsLayout()
        }
    }
    
    func updateCurrentLocationWithoutZoom() {
        
        var mapRegion : MKCoordinateRegion = MKCoordinateRegion()
        if let location = self.currentLocation {
            mapRegion.center = location.coordinate
            mapRegion.span.latitudeDelta = 0.013
            mapRegion.span.longitudeDelta = 0.013
            self.mapView.setRegion(mapRegion, animated: true)
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            return nil
        }
        if annotation is FMAnnotationCurrent {
            if let pinView = self.mapView.dequeueReusableAnnotationView(withIdentifier: "FMAnnotationCurrent") as? SVPulsingAnnotationView {
                return pinView
            } else {
                return SVPulsingAnnotationView.init(annotation: annotation, reuseIdentifier: "FMAnnotationCurrent")
            }
        }
        if annotation is FMAnnotation {
            if let pinView : FMPinAnnotationView = self.mapView.dequeueReusableAnnotationView(withIdentifier: "FMAnnotation") as? FMPinAnnotationView {
                return pinView
            } else {
                return FMPinAnnotationView.init(annotation: annotation, reuseIdentifier: "FMAnnotation")
            }
        }
        return nil
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        if view is FMPinAnnotationView {
            view.image = UIImage(named: "car2go_selected_with_text")
            view.isSelected = true
            if let annotation = view.annotation as? FMAnnotation {
                
                if let vehicle = annotation.vehicle {
                    let indexPath : NSIndexPath = NSIndexPath(row: vehicle.index!-1, section: 0)
                    var scrollPosition : UITableViewScrollPosition = .none
                    
                    if (self.tableView.indexPathsForVisibleRows?.contains(indexPath as IndexPath))! == false {
                        scrollPosition = .top
                    }
                    self.tableView.selectRow(at: indexPath as IndexPath, animated: true, scrollPosition: scrollPosition)
                }
                self.drawRoute(coordinateStart: CLLocationCoordinate2D(latitude: self.mapView.userLocation.coordinate.latitude, longitude: self.mapView.userLocation.coordinate.longitude),
                               coordinateEnd: CLLocationCoordinate2D(latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude),
                               completion: { bool in
                })
            }
        }
    }

    func drawRoute(coordinateStart: CLLocationCoordinate2D, coordinateEnd: CLLocationCoordinate2D, completion: @escaping (Bool?) -> Void) {
        
        let directionsRequest : MKDirectionsRequest = MKDirectionsRequest()
        let placemarkStart : MKPlacemark = MKPlacemark(coordinate: coordinateStart)
        let placemarkEnd : MKPlacemark = MKPlacemark(coordinate: coordinateEnd)
        
        directionsRequest.source = MKMapItem(placemark: placemarkStart)
        directionsRequest.destination = MKMapItem(placemark: placemarkEnd)
        directionsRequest.transportType = .automobile
        
        let directions : MKDirections = MKDirections.init(request: directionsRequest)
        directions.calculate { (response, error) in
            if error == nil {
                
                DispatchQueue.main.async {
                    self.clearRoute()
                    self.routeDetails = response?.routes.last
                    self.mapView.add((self.routeDetails?.polyline)!, level: .aboveRoads)
                    self.mapView.setNeedsDisplay()
                    self.mapView.layer.setNeedsDisplay()
                    completion(true)
                }
            } else {
                print("Error : \(String(describing: error?.localizedDescription))")
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        
        if view is FMPinAnnotationView {
            view.image = UIImage(named: "car2go_with_text")
            view.isSelected = true
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        let renderer = MKPolylineRenderer(polyline: (self.routeDetails?.polyline)!)
        renderer.strokeColor = Const.FMMapLineColor
        renderer.alpha = 0.7
        renderer.lineWidth = 4
        renderer.lineDashPattern = [2, 5]
        return renderer
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        if let annotation = view.annotation as? FMAnnotation {
            self.openCar2GoApp(vehicle: annotation.vehicle)
        }
    }
    
    func openCar2GoApp(vehicle: Vehicle?) {
        
        // car2go://vehicle/WME4513341K828695?latlng=53.58775,10.12023
        if let vin = vehicle?.vin, let latitude = vehicle?.latitude, let longitude = vehicle?.longitude {
            let url = "car2go://vehicle/\(vin)?latlng=\(latitude),\(longitude)"
            UIApplication.shared.open(URL(string: url)!, options: [:]) { success in
                print("open \(success)")
            }
        }
    }
}
