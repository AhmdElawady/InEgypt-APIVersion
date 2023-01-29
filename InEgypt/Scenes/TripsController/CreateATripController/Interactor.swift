//
//  CreateTripService.swift
//  InEgypt
//
//  Created by Awady on 6/3/21.
//  Copyright © 2021 AwadyStore. All rights reserved.
//

import Foundation

class CreateTripService {
    
    static let shared = CreateTripService()
    let genaricNetworking = GenaricNetworking()
    
    func fetchDestinations(completion: @escaping (TripDataResponse?, Error?) -> Void) {
        let urlString = URLRouter.TripRequestEndPoints.destinations.stringValue
        genaricNetworking.getRequest(urlString: urlString, completion: completion)
    }
    
    func fetchSearched(searchTerm: String, completion: @escaping (TripSearchResponse?, Error?) -> Void) {
        let urlString = "\(URLRouter.TripRequestEndPoints.searched.stringValue)\(searchTerm)"
        let urlStringEncoded = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        genaricNetworking.getRequest(urlString: urlStringEncoded ?? "", completion: completion)
    }
    
    func postATripRequest(body: TripRequestBody, completion: @escaping (TripRequestResponse?, Error?) -> Void) {
        let urlString = URL(string: URLRouter.TripRequestEndPoints.addRequest.stringValue)!
        var request = URLRequest(url: urlString)
        request.httpMethod = "POST"
        request.addValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONEncoder().encode(body)
        
        genaricNetworking.postRequest(request: request, completion: completion)
    }
}
