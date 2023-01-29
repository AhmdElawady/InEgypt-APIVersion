//
//  ViewController.swift
//  InEgypt
//
//  Created by Awady on 8/28/20.
//  Copyright © 2020 AwadyStore. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MapView {
    
    let mapView = MKMapView()
    
    let distanceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .blackToWhite
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    lazy var directionButton: UIButton = {
        let button = UIButton(type: .system)
        let imageConfigration = UIImage.SymbolConfiguration(pointSize: 16, weight: .semibold, scale: .medium)
        let btnImage = UIImage(systemName: "arrow.swap", withConfiguration: imageConfigration)
        let tintedImage = btnImage?.withRenderingMode(.alwaysOriginal).withTintColor(.appBlue)
        button.setImage(tintedImage, for: .normal)
        button.addTarget(self, action: #selector(directionPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var openMapsButton: UIButton = {
        let button = UIButton(type: .system)
        let imageConfigration = UIImage.SymbolConfiguration(pointSize: 16, weight: .semibold, scale: .medium)
        let btnImage = UIImage(systemName: "map", withConfiguration: imageConfigration)
        let tintedImage = btnImage?.withRenderingMode(.alwaysOriginal).withTintColor(.appBlue)
        button.setImage(tintedImage, for: .normal)
        button.addTarget(self, action: #selector(showAvailableMaps), for: .touchUpInside)
        return button
    }()
    
//    var id = Int()
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 10000
    var placeTitle = ""
    var placeType = ""
    var poster = ""
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    
//    convenience init(id: Int) {
//        self.init()
//        self.id = id
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        setupView()
    }
    
    private func setupView() {
        view.addSubview(mapView)
        mapView.fillSuperview()
        
        mapView.addSubview(distanceLabel)
        distanceLabel.anchor(top: mapView.topAnchor, left: mapView.leftAnchor, topConstant: 20, leftConstant: 20)
        
        let buttonsStack: UIStackView = {
            let separator = UIView()
            separator.anchor(heightConstant: 1)
            separator.backgroundColor = .systemGray2
            let stackView = UIStackView(arrangedSubviews: [directionButton, separator, openMapsButton])
            stackView.axis = .vertical
            stackView.spacing = 10
            return stackView
        }()
        
        let stackContainer: UIView = {
            let view = UIView()
            view.backgroundColor = .whiteToBlack.withAlphaComponent(0.6)
            view.layer.cornerRadius = 5
            return view
        }()
        
        stackContainer.addSubview(buttonsStack)
        buttonsStack.anchor(top: stackContainer.topAnchor, left: stackContainer.leftAnchor, bottom: stackContainer.bottomAnchor, right: stackContainer.rightAnchor, topConstant: 10, leftConstant: 4, bottomConstant: 10, rightConstant: 4)
        
        mapView.addSubview(stackContainer)
        stackContainer.anchor(top: mapView.topAnchor, right: mapView.rightAnchor, topConstant: 10, rightConstant: 10, widthConstant: 32)
    }
    
    func displayMap(map: Info) {
        self.placeTitle = map.title
        self.placeType = map.type
        self.poster = map.poster
        
        self.latitude = Double(map.latitude) ?? 0.0
        self.longitude = Double(map.longitude) ?? 0.0
        setAnnotation()
    }
    
    func checkLocationServices() {
        checkLocationAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func setAnnotation() {
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let annotation = CustomAnnotation(title: placeTitle, distance: nil, discepline: placeType, coordinate: coordinate, poster: poster, categoryId: nil)
        mapView.addAnnotation(annotation)
        centerViewOnDestinationLocation()
    }
    
    @objc private func directionPressed() {
        checkLocationAuthorization()
        getDirection()
        getDistance()
    }
    
    @objc private func showAvailableMaps(actionSheet: UIAlertController) {
        let actionSheet = UIAlertController(title: "Choose Maps".localized, message: "", preferredStyle: .actionSheet)
        let dismissAction = UIAlertAction(title: "Cancel".localized, style: .cancel)
        let appleMapsAction = UIAlertAction(title: "Maps".localized, style: .default) { (aciton) in
            self.openAppleMaps()
        }
        let googleMapsAction = UIAlertAction(title: "Google Maps".localized, style: .default) { (aciton) in
            self.openGoogleMaps()
        }
        
        if let popoverController = actionSheet.popoverPresentationController {
          popoverController.sourceView = self.view
          popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
        }
        
        actionSheet.addAction(dismissAction)
        actionSheet.addAction(appleMapsAction)
        actionSheet.addAction(googleMapsAction)
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    private func openAppleMaps() {
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        let option = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center), MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)]
        let placeMark = MKPlacemark(coordinate: coordinates)
        let mapItem = MKMapItem(placemark: placeMark)
//        mapItem.name = title
        mapItem.openInMaps(launchOptions: option)
    }
    
    private func openGoogleMaps() {
        let app = UIApplication.shared
        if app.canOpenURL(URL(string:"comgooglemaps://")!) {  //if phone has an app
            let string = "comgooglemaps://?saddr=&daddr=\(latitude),\(longitude)&directionsmode=driving"
            if let url = URL(string: string) {
                app.open(url, options: [:]) }
        } else { //Open in browser
            if let urlDestination = URL.init(string: "https://www.google.co.in/maps/dir/?saddr=&daddr=\(latitude),\(longitude)&directionsmode=driving") {
                app.open(urlDestination) }
        }
    }
    
    func centerViewOnDestinationLocation() {
        let placeLocation = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let region = MKCoordinateRegion.init(center: placeLocation, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        mapView.setRegion(region, animated: true)
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
//            locationManager.requestAlwaysAuthorization()
            mapView.showsUserLocation = true
//            locationManager.startUpdatingLocation()
            break
        case .denied:
            askToOpenLocationWithAction()
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted:
            askToOpenLocationWithAction()
            break
        case .authorizedAlways:
            mapView.showsUserLocation = true
//            locationManager.startUpdatingLocation()
            break
        case .none:
            break
        @unknown default:
            break
        }
    }
    
    func getCentralLocation(for mapView: MKMapView) -> CLLocation {
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    
    func createDirectionsRequest(from coordinate: CLLocationCoordinate2D) -> MKDirections.Request {
        let destinationCoordinate = getCentralLocation(for: mapView).coordinate
        let startingLocation = MKPlacemark(coordinate: coordinate)
        let destination = MKPlacemark(coordinate: destinationCoordinate)
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: startingLocation)
        request.destination = MKMapItem(placemark: destination)
        request.transportType = .automobile
        request.requestsAlternateRoutes = true
        
        return request
    }
    
    func getDirection() {
        guard let location = locationManager.location?.coordinate else { return }
        
        let request = createDirectionsRequest(from: location)
        let directions = MKDirections(request: request)
        
        directions.calculate { [unowned self] (response, error) in
            guard let response = response else {return}
            for route in response.routes {
                self.mapView.addOverlay(route.polyline)
                self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
            }
        }
    }
    
    func getDistance() {
        guard let location = locationManager.location?.coordinate else { return }
        let currentLat = location.latitude
        let currentLong = location.longitude
        let myLocation = CLLocation(latitude: currentLat, longitude: currentLong)
        let destination = CLLocation(latitude: latitude, longitude: longitude)
        let distanceInKiloMeter = myLocation.distance(from: destination) / 1000
        distanceLabel.text = String(format: "%.2f", distanceInKiloMeter)+" km".localized
    }
    
    private func askToOpenLocationWithAction() {
        Alert.locationDisabledAlert(on: self)
    }
}

//
extension MapViewController : MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolyline {
            let routeRenderer = MKPolylineRenderer(overlay: overlay)
            routeRenderer.strokeColor = #colorLiteral(red: 0.042927064, green: 0.5177074075, blue: 1, alpha: 1)
            routeRenderer.lineWidth = 2.5

            return routeRenderer

        } else if overlay is MKCircle {
            var circleRenderer = MKCircleRenderer()
            if let overlay = overlay as? MKCircle {
                circleRenderer = MKCircleRenderer(circle: overlay)
                circleRenderer.fillColor = .appGreen
                circleRenderer.alpha = 0.2
                circleRenderer.strokeColor = .black
            }
            return circleRenderer
        }
        return MKOverlayRenderer()
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
        view.leftCalloutAccessoryView = self.annotationViewImage(imageView: imageView)
        
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
}

//extension MapViewController: CLLocationManagerDelegate {
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        checkLocationAuthorization()
//    }
//}
