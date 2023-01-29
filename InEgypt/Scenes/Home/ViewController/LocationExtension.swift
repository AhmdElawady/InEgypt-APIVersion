//
//  VC+CoreLocation.swift
//  InEgypt
//
//  Created by Awady on 9/13/22.
//  Copyright © 2022 AwadyStore. All rights reserved.
//

import UIKit
import CoreLocation

extension HomeController: CLLocationManagerDelegate {
    func checkLocationServices() {
        checkLocationAuthorization()
        updatedUserLocation()
    }
    
    func askToOpenUserLocation() {
        let alert = UIAlertController(title: "locationDisabled".localized, message: "locationAlertDescription".localized, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK".localized, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func checkLocationAuthorization() {
        var authorizationStatus: CLAuthorizationStatus?
        if #available(iOS 14.0, *) {
            authorizationStatus = locationManager.authorizationStatus
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus()
        }
        
        switch authorizationStatus {
        case .authorizedWhenInUse:
            updatedUserLocation()
            break
        case .denied:
//            askToOpenUserLocation()
            break
        case .notDetermined:
//            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted:
            break
        case .authorizedAlways:
            updatedUserLocation()
            break
        case .none:
            break
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
        updatedUserLocation()
    }
    
    func updatedUserLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
        guard let userLocation = locationManager.location?.coordinate else { return }
        let userLatitude = "\(userLocation.latitude)"
        let userLongitude = "\(userLocation.longitude)"
        presenter.getAround(lat: userLatitude, long: userLongitude)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation: CLLocation = locations.last! as CLLocation
        manager.stopUpdatingLocation()
        let latitude = "\(userLocation.coordinate.latitude)"
        let longitude = "\(userLocation.coordinate.longitude)"
        presenter.getAround(lat: latitude, long: longitude)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
}
