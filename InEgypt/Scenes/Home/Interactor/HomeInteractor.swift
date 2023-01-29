//
//  HomeService.swift
//  InEgypt
//
//  Created by Awady on 5/26/21.
//  Copyright © 2021 AwadyStore. All rights reserved.
//

import Foundation

class HomeInteractor {
    
    static let shared = HomeInteractor()
    let genaricNetworking = GenaricNetworking()
    
    func fetchAds(completion: @escaping (AdsResponse?, Error?) -> Void) {
        let urlString = URLRouter.HomeEndPoints.ads.stringValue
        genaricNetworking.getRequest (urlString: urlString, completion: completion)
    }
    
    func fetchCategories(completion: @escaping (CategoryResponse?, Error?) -> Void) {
        let urlString = URLRouter.HomeEndPoints.categories.stringValue
        genaricNetworking.getRequest(urlString: urlString, completion: completion)
    }
    
    func fetchRecommendedAttractions(completion: @escaping (RecommendedResponse?, Error?) -> Void) {
        let urlString = URLRouter.HomeEndPoints.attractions.stringValue
        genaricNetworking.getRequest(urlString: urlString, completion: completion)
    }
    
    func fetchRecommendedSpots(completion: @escaping (RecommendedResponse?, Error?) -> Void) {
        let urlString = URLRouter.HomeEndPoints.spots.stringValue
        genaricNetworking.getRequest(urlString: urlString, completion: completion)
    }
    
    func fetchAround(lat: String, long: String, completion: @escaping (AroundResponse?, Error?) -> Void) {
        let urlString = URLRouter.HomeEndPoints.around.stringValue
        var request = URLRequest(url: URL(string: urlString)!)
        request.httpMethod = "POST"
        request.addValue("Application/json", forHTTPHeaderField: "Content-Type")
        let body = CoordinatesPost(latitude: lat, longitude: long)
        request.httpBody = try! JSONEncoder().encode(body)
        genaricNetworking.postRequest(request: request, completion: completion)
    }
    
    func fetchAllMapAttractions(completion: @escaping (MapAttractionsResponse?, Error?) -> Void) {
        let urlString = URLRouter.HomeEndPoints.mapAttraction.stringValue
        genaricNetworking.getRequest(urlString: urlString, completion: completion)
    }
    
    func fetchHomeCities(completion: @escaping (HomeCitiesResponse?, Error?) -> Void) {
        let urlString = URLRouter.HomeEndPoints.cities.stringValue
        genaricNetworking.getRequest(urlString: urlString, completion: completion)
    }
}
