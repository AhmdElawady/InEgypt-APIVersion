//
//  LocationManagerDelegate.swift
//  InEgypt
//
//  Created by Awady on 10/12/22.
//  Copyright © 2022 AwadyStore. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

extension NearbyController: CLLocationManagerDelegate {
    
    internal func setupLocationServices() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        initialCheckForLocationAuthorization()
    }

    private func initialCheckForLocationAuthorization() {
        var authorizationStatus: CLAuthorizationStatus?
        
        if #available(iOS 14.0, *) {
            authorizationStatus = locationManager.authorizationStatus
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus()
        }
        
        switch authorizationStatus {
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            initialCenterViewOnUserLocation()
            break
        case .denied:
            addAllAnnotations()
            break
        case .notDetermined:
            addAllAnnotations()
            break
        case .restricted:
            addAllAnnotations()
            break
        case .authorizedAlways:
            mapView.showsUserLocation = true
            initialCenterViewOnUserLocation()
            break
        case .none:
            break
        @unknown default:
            break
        }
    }

    internal func initialCenterViewOnUserLocation() {
        fetchNearbyUserLocation()
        let redius = Double(sliderValue * 1000)
        guard let location = locationManager.location?.coordinate else { return }
        let region = MKCoordinateRegion.init(center: location, latitudinalMeters: redius*2, longitudinalMeters: redius*2)
        mapView.setRegion(region, animated: true)
        showCircle(coordinate: location, radius: redius)
        setCenterButtonImage(imageName: "location.fill")
        selectedMapRegion = location
    }
    
//    func askToOpenUserLocation() {
//        let alert = UIAlertController(title: "locationDisabled".localized, message: "locationAlertDescription".localized, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OK".localized, style: .default, handler: nil))
//        self.present(alert, animated: true, completion: nil)
//    }
    
    internal func showCircle(coordinate: CLLocationCoordinate2D, radius: CLLocationDistance) {
        let circle = MKCircle(center: coordinate, radius: radius)
        mapView.removeOverlays(mapView.overlays)
        mapView.addOverlay(circle)
    }
    
    func addAllAnnotations() {
        presenter.fetchAllMapDestination()
    }
    
    internal func addAroundAnnotationsWithRadius() {
        filteredDestinations.removeAll()
        mapView.removeAnnotations(mapView.annotations)
        
        var segmentedDestinations: [HomeAround] = []
        
        switch segmentedControl.selectedSegmentIndex {
        case 0: segmentedDestinations = presenter.nearbyDestinations
        case 1: segmentedDestinations = presenter.nearbyDestinations.filter({$0.type == "0"})
        case 2: segmentedDestinations = presenter.nearbyDestinations.filter({$0.type == "1"})
        default: break
        }
        
        let nearby = segmentedDestinations.filter { $0.distance <= Double(sliderValue) }
        
        let annotations = nearby.map { destination -> CustomAnnotation in
            let latitude = Double(destination.latitude) ?? Double()
            let longitude = Double(destination.longitude) ?? Double()
            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let annotation = CustomAnnotation(title: destination.name, distance: nil, discepline: destination.type, coordinate: coordinate, poster: destination.poster, categoryId: destination.poster)
//            if destination.distance <= Double(sliderValue) { filteredDestinations.append(destination) }
            filteredDestinations = nearby
            return annotation
        }
        
        mapView.addAnnotations(annotations)
        passNearbyToPanel()
    }
    
    private func passNearbyToPanel() {
        nearbyPanelController.nearby = filteredDestinations
        nearbyPanelController.reloadSectionLayout()
    }
    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        let userLocation: CLLocation = locations.last! as CLLocation
//        manager.stopUpdatingLocation()
//        let latitude = "\(userLocation.coordinate.latitude)"
//        let longitude = "\(userLocation.coordinate.longitude)"
//        presenter.fetchUserLocationNearby(userLatitude: latitude, userLongitude: longitude)
//        manager.startUpdatingLocation()
//    }
    
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        checkLocationAuthorization()
//    }
}

extension NearbyController: MKMapViewDelegate    {
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        var circleRenderer = MKCircleRenderer()
        if let overlay = overlay as? MKCircle {
            circleRenderer = MKCircleRenderer(circle: overlay)
            circleRenderer.fillColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
            
            circleRenderer.alpha = 0.3
            circleRenderer.strokeColor = .iconBackgroundGray
        }
        return circleRenderer
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard !(annotation is MKUserLocation) else { return nil }
        guard let annotation = annotation as? CustomAnnotation else { return nil }
        
        var view: MKMarkerAnnotationView
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: annotation.identifier) as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else { view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: annotation.identifier) }
        
        view.canShowCallout = true
//        view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        
        let imageView = UIImageView()
        ImageService.downloadImage(withData: annotation.poster ?? "", imageView: imageView)
        
        if annotation.poster == nil {
            view.leftCalloutAccessoryView = nil
        } else {
            view.leftCalloutAccessoryView = self.annotationViewImage(imageView: imageView)
        }
        
        if annotation.discepline == "0" {
            view.glyphText = "A"
        } else {
            view.glyphText = "S"
        }
        
        view.markerTintColor = annotation.markerTintColor
        
        return view
    }
    
    private func annotationViewImage(imageView: UIImageView) -> UIImageView {
        imageView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        imageView.layer.borderWidth = 1.0
        imageView.layer.borderColor = UIColor.appYellow.cgColor
        imageView.layer.cornerRadius = imageView.frame.size.width/2
        imageView.clipsToBounds = true
        return imageView
    }
    
    
    // annotation view selection to open details screen
    
//    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
//        guard let annotation = view.annotation as? CustomAnnotation else { return }
//        let detailsController = DetailsController()
//        let detailsPresenter = DetailsPresenter(view: detailsController, id: annotation.id)
//        detailsController.presenter = detailsPresenter
//        self.navigationController?.pushViewController(detailsController, animated: true)
//    }
    
    
}
    

