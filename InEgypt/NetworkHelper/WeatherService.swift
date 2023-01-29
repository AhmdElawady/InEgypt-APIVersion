//
//  WeatherService.swift
//  InEgypt
//
//  Created by Awady on 6/22/21.
//  Copyright © 2021 AwadyStore. All rights reserved.
//

import Foundation

class WeatherService {
    
    static let shared = WeatherService()
    let genaricNetworking = GenaricNetworking()
    
    func getTemp(latitude: String, longitude: String, completion: @escaping (WeatherResponse?, Error?) -> Void) {
        let apiKey = "95b988fb272a4ecbb87103142212106"
        let baseUrl = "https://api.weatherapi.com/v1"
        let urlString = "\(baseUrl)/current.json?key=\(apiKey)&q=\(latitude),\(longitude)&aqi=no"
        genaricNetworking.getRequest(urlString: urlString, completion: completion)
    }
}
