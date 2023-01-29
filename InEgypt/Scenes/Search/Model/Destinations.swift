//
//  Destinations.swift
//  InEgypt
//
//  Created by Awady on 5/26/21.
//  Copyright © 2021 AwadyStore. All rights reserved.
//

import Foundation

// Destination Model
struct DestinationsResponse: Decodable {
    let data: [Destination]
}
struct Destination: Decodable {
    let id: Int
    let poster, name, city, longitude, latitude: String
    let rate: Int?
}


// Search Model
struct SearchResponse: Decodable {
    let data: SearchData?
}
struct SearchData: Decodable {
    let result: [Search]
    let resultCount: Int?
}
struct Search: Decodable {
    let id: Int
    let name, city, category : String
}

struct WeatherResponse: Decodable {
    let current: weatherData?
}
struct weatherData: Decodable {
    let temp: Double
    enum CodingKeys: String, CodingKey {
        case temp = "temp_c"
    }
}

