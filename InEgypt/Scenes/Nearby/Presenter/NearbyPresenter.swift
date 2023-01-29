//
//  NearbyPresenter.swift
//  InEgypt
//
//  Created by Awady on 10/10/22.
//  Copyright © 2022 AwadyStore. All rights reserved.
//

import Foundation
import Nuke

protocol NearbyView: AnyObject {
    func fetchingDataSuccess()
    func fetchSuccessMapAnnotation(mapAttractions: [MapAttraction])
    func showNearbyAreaButtonLoading()
    func hideNearbyAreaButtonLoading()
}


class NearbyPresenter {
    
    private weak var view: NearbyView?
    private let interactor = HomeInteractor()
    var nearbyDestinations: [HomeAround] = []
//    var allMapAnnotations: [MapAttraction] = []
    
    init(view: NearbyView) {
        self.view = view
    }
    
    func fetchNearby(userLatitude: String, userLongitude: String) {
        HomeInteractor.shared.fetchAround(lat: userLatitude, long: userLongitude) { around, error in
            if error != nil { print("around error") }
            self.nearbyDestinations = around?.data ?? []
            self.view?.fetchingDataSuccess()
        }
    }
    
    func fetchAreaNearby(userLatitude: String, userLongitude: String) {
        view?.showNearbyAreaButtonLoading()
        HomeInteractor.shared.fetchAround(lat: userLatitude, long: userLongitude) { around, error in
            if error != nil { print("around area error") }
            self.nearbyDestinations = around?.data ?? []
            self.view?.fetchingDataSuccess()
            self.view?.hideNearbyAreaButtonLoading()
        }
    }
    
    func fetchAllMapDestination() {
        HomeInteractor.shared.fetchAllMapAttractions { mapAttractions, error in
            if error != nil { print("map attraction error") }
            let allMapAnnotations = mapAttractions?.data ?? []
            self.view?.fetchSuccessMapAnnotation(mapAttractions: allMapAnnotations)
        }
    }
}
