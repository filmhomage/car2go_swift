//
//  FMViewController.swift
//  car2go_sample
//
//  Created by Jonghyun Kim on 2017/06/14.
//  Copyright © 2017 kokaru. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class FMViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewLeftContainer: UIView!
    @IBOutlet weak var buttonCurrentLocation: UIButton!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var constraintLeftWidth: NSLayoutConstraint!
    
    var routeDetails : MKRoute?
    var arrayVehicles : [Vehicle]?
    var currentLocation : CLLocation?
    var locationManager : CLLocationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.requestWhenInUseAuthorization()
        self.initializeLocation()
        self.initializeMap()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getAPI()
    }
    
    @IBAction func currentLocatioinButtonTapped(_ sender: UIButton) {
        
        self.updateCurrentLocationWithoutZoom()
    }
    
    @IBAction func segmentedValueChanged(_ sender: UISegmentedControl) {
    }
    
    func getAPI() {
        
        FMAPIManager.sharedInstance.vehiclesAPI { vehicles in
            if let vehicle = vehicles {
                self.arrayVehicles = vehicle
                self.addAnnotation(array: self.arrayVehicles!)
                self.tableView.reloadData()
                self.updateCurrentLocationWithoutZoom()
            }
        }
    }
}
