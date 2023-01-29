//
//  CitiesService.swift
//  InEgypt
//
//  Created by Awady on 6/1/21.
//  Copyright © 2021 AwadyStore. All rights reserved.
//

import Foundation


class CityInteractor {
    
    static let shared = CityInteractor()
    let genaricNetworking = GenaricNetworking()
    
    func fetchCities(completion: @escaping (CitiesResponse?, Error?) -> Void) {
        let urlString = URLRouter.CityEndPoints.cities.stringValue
        genaricNetworking.getRequest(urlString: urlString, completion: completion)
    }
    
    func fetchCity(id: Int, completion: @escaping (CityResponse?, Error?) -> Void) {
        let urlString = URL(string: URLRouter.CityEndPoints.city.stringValue)!
        var request = URLRequest(url: urlString)
        request.httpMethod = "POST"
        request.addValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONEncoder().encode(["id": id])
        genaricNetworking.postRequest(request: request, completion: completion)
    }
    
    
    func fetchCityTenAttraction(id: Int, completion: @escaping (CityTenItemsResponse?, Error?) -> Void) {
        let urlString = URL(string: URLRouter.CityEndPoints.cityAttractions.stringValue)!
        var request = URLRequest(url: urlString)
        request.httpMethod = "POST"
        request.addValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONEncoder().encode(["id": id])
        genaricNetworking.postRequest(request: request, completion: completion)
    }
    
    func fetchCityTenSpots(id: Int, completion: @escaping (CityTenItemsResponse?, Error?) -> Void) {
        let urlString = URL(string: URLRouter.CityEndPoints.citySpots.stringValue)!
        var request = URLRequest(url: urlString)
        request.httpMethod = "POST"
        request.addValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONEncoder().encode(["id": id])
        genaricNetworking.postRequest(request: request, completion: completion)
    }
    
    func fetchAllCityDestinations(id: Int, completion: @escaping (CityDestinationsResponse?, Error?) -> Void) {
        let urlString = URL(string: URLRouter.CityEndPoints.cityDestinations.stringValue)!
        var request = URLRequest(url: urlString)
        request.httpMethod = "POST"
        request.addValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONEncoder().encode(["id": id])
        genaricNetworking.postRequest(request: request, completion: completion)
    }
}
