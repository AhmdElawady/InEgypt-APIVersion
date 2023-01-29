//
//  DestinationsService.swift
//  InEgypt
//
//  Created by Awady on 5/26/21.
//  Copyright © 2021 AwadyStore. All rights reserved.
//

import Foundation

class DestinationService {
    
    static let shared = DestinationService()
    let genaricNetworking = GenaricNetworking()
    
    func fetchAttractions(completion: @escaping (DestinationsResponse?, Error?) -> Void) {
        let urlString = URLRouter.DestinationEndPoints.attractions.stringValue
        genaricNetworking.getRequest(urlString: urlString, completion: completion)
    }
    
    func fetchSpots(completion: @escaping (DestinationsResponse?, Error?) -> Void) {
        let urlString = URLRouter.DestinationEndPoints.spots.stringValue
        genaricNetworking.getRequest(urlString: urlString, completion: completion)
    }
    
    func fetchSearched(searchTerm: String, completion: @escaping (SearchResponse?, Error?) -> Void) {
        let urlString = "\(URLRouter.DestinationEndPoints.searchDestination.stringValue)\(searchTerm)"
        let urlStringEncoded = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        genaricNetworking.getRequest(urlString: urlStringEncoded ?? "", completion: completion)
    }
}
