//
//  NearbyPresenterDelegte.swift
//  InEgypt
//
//  Created by Awady on 10/10/22.
//  Copyright © 2022 AwadyStore. All rights reserved.
//

import UIKit
import MapKit

extension NearbyController: NearbyView {
    
    func fetchSuccessMapAnnotation(mapAttractions: [MapAttraction]) {
        DispatchQueue.main.async {
            let annotations = mapAttractions.map { destination -> CustomAnnotation in
                let latitude = Double(destination.latitude) ?? Double()
                let longitude = Double(destination.longitude) ?? Double()
                let coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                let annotation = CustomAnnotation(title: destination.name, distance: nil, discepline: "0", coordinate: coordinates, poster: nil, categoryId: nil)
                
                return annotation
            }
            return self.mapView.addAnnotations(annotations)
        }
    }
    

    func fetchingDataSuccess() {
        DispatchQueue.main.async {
            self.addAroundAnnotationsWithRadius()
            self.nearbyPanelController.collectionView.reloadData()
            if self.filteredDestinations.count == 0 {
                Banner.basicBannerView(title: "", message: "No result found in this area".localized, iconText: "")
            }
        }
    }
    
    func showNearbyAreaButtonLoading() {
        DispatchQueue.main.async {
            self.nearbyThisAreaButton.showLoading()
        }
    }
    
    func hideNearbyAreaButtonLoading() {
        DispatchQueue.main.async {
            self.nearbyThisAreaButton.hideLoading()
        }
    }
    
    
//    func fetchSuccessAreaAnnotation(mapAttractions: [MapAttraction]) {
//        DispatchQueue.main.async {
//            self.addAroundAnnotationsWithRadius()
//        }
//    }
    
    
}
    
