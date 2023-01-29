//
//  CityMapController.swift
//  InEgypt
//
//  Created by Awady on 4/19/21.
//  Copyright © 2021 AwadyStore. All rights reserved.
//

import UIKit
import MapKit

class CityMapController: UIViewController {
    
    var mapView = MKMapView()
    
    lazy var dismissButton: UIButton = {
        let button = UIButton(type: .system)
        let btnImage = UIImage(systemName: "xmark")
        let tintedImage = btnImage?.withRenderingMode(.alwaysTemplate)
        button.setImage(tintedImage, for: .normal)
        button.tintColor = .appBlue
        button.addTarget(self, action: #selector(dismissPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var topView: UIView = {
        let view = UIView()
        view.backgroundColor = .backgroundColor
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(topViewPressed))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        view.addGestureRecognizer(tapGesture)
        view.isUserInteractionEnabled = true
        return view
    }()
    
    var id = Int()
    var latitude = ""
    var longitude = ""
    convenience init(id: Int, latitude: String, longitude: String) {
        self.init()
        self.id = id
        self.latitude = latitude
        self.longitude = longitude
    }
    
    var mapAttraction: [CityDestination] = []
    var mapSpots: [CityDestination] = []
    
    var tapGesture = UITapGestureRecognizer()
    let regionInMeters: Double = 100000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        addSubViews()
        setAnnotation()
    }
    
    private func addSubViews() {
        view.addSubview(topView)
        topView.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, rightConstant: 0, heightConstant: 70)
        
        topView.addSubview(dismissButton)
        dismissButton.anchor(top: topView.topAnchor, bottom: topView.bottomAnchor, right: topView.rightAnchor, topConstant: 10, bottomConstant: 10, rightConstant: 10, widthConstant: 30)
        
        view.addSubview(mapView)
        mapView.anchor(top: topView.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0)
    }
    
    func setAnnotation() {
        
        CityInteractor.shared.fetchAllCityDestinations(id: id) { destinatins, error in
            if error != nil { print("map city error") }
            self.mapAttraction = destinatins?.data.attraction ?? []
            self.mapSpots = destinatins?.data.spot ?? []
            DispatchQueue.main.async {
                self.centerViewOnDestinationLocation()
                self.addAnnotations()
            }
        }
    }
    
    private func addAnnotations() {
        
        let attractionsAnnotations = mapAttraction.map { attraction -> CustomAnnotation in
            let latitude = Double(attraction.latitude) ?? Double()
            let longitude = Double(attraction.longitude) ?? Double()
            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            
            let annotation = CustomAnnotation(title: attraction.name, distance: nil, discepline: "0", coordinate: coordinate, poster: attraction.poster, categoryId: nil)
            return annotation
        }
        
        let spotsAnnotations = mapSpots.map { spot -> CustomAnnotation in
            let latitude = Double(spot.latitude) ?? Double()
            let longitude = Double(spot.longitude) ?? Double()
            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            
            let annotation = CustomAnnotation(title: spot.name, distance: nil, discepline: "1", coordinate: coordinate, poster: spot.poster, categoryId: nil)
            return annotation
        }
        
        let annotations: [CustomAnnotation] = attractionsAnnotations + spotsAnnotations
        
        return self.mapView.addAnnotations(annotations)
    }
    
    func centerViewOnDestinationLocation() {
        let location = CLLocationCoordinate2D(latitude: Double(latitude) ?? Double(), longitude: Double(longitude) ?? Double())
        let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        mapView.setRegion(region, animated: true)
    }
    
    @objc private func dismissPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func topViewPressed() {
        dismiss(animated: true, completion: nil)
    }
}

extension CityMapController: MKMapViewDelegate    {

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

        guard !(annotation is MKUserLocation) else { return nil }
        guard let annotation = annotation as? CustomAnnotation else { return nil }

        var view: MKMarkerAnnotationView
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: annotation.identifier) as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else { view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: annotation.identifier) }

        view.canShowCallout = true

        let imageView = UIImageView()
        ImageService.downloadImage(withData: annotation.poster ?? "", imageView: imageView)

        if annotation.poster == nil {
            view.leftCalloutAccessoryView = nil
        } else {
            view.leftCalloutAccessoryView = self.annotationViewImage(imageView: imageView)
        }
        if annotation.discepline == "0" { view.glyphText = "A" } else { view.glyphText = "S" }
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
