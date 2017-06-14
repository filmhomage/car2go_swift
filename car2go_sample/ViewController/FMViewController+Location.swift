//
//  FMViewController+Location.swift
//  car2go_sample
//
//  Created by Jonghyun Kim on 2017/06/14.
//  Copyright © 2017 kokaru. All rights reserved.
//

import Foundation
import CoreLocation

extension FMViewController : CLLocationManagerDelegate {
    
    func initializeLocation() {
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        self.locationManager.requestLocation()
    }
    
    static func locationServicesEnabled() -> Bool {
        
        var bEnable : Bool = true
        let status : CLAuthorizationStatus = CLLocationManager.authorizationStatus()
        switch status {
        case .notDetermined:
            bEnable = false
            break
        case .restricted:
            bEnable = false
            break
        case .denied:
            bEnable = false
            break
        default:
            bEnable = true
            break
        }
        return bEnable
    }
    
    func requestLocation() {
        self.locationManager.requestLocation()
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("didFailWithError : \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
        case .notDetermined:
            print("notDetermined")
            break
        case .restricted:
            print("restricted")
            break
        case .denied:
            print("denied")
            break
            
        default:
            self.requestLocation()
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let currentLocation : CLLocation = locations.last {
            self.currentLocation = currentLocation
            print("✅ GPS [ \(currentLocation) ] [ \(currentLocation.coordinate.latitude) -- \(currentLocation.coordinate.longitude)]")
        }
        self.updateCurrentLocationWithoutZoom()
    }
    
}
