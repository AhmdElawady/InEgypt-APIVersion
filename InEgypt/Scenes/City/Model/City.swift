//
//  City.swift
//  InEgypt
//
//  Created by Awady on 8/7/20.
//  Copyright © 2020 AwadyStore. All rights reserved.
//

import Foundation

// Cities Model
struct CitiesResponse: Decodable {
    let data: [CityItem]
}
struct CityItem: Decodable {
    let id: Int
    let title, poster: String
    let attCount, spotCount: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case title = "city"
        case poster
        case attCount = "count_att"
        case spotCount = "count_spot"
    }
}

// City Model
struct CityResponse: Decodable {
    let data: City
}
struct City: Decodable {
    let id: Int
    let title, poster, about, population, residency, area, longitude, latitude: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title = "city"
        case poster
        case about = "overview"
        case population
        case area
        case residency
        case longitude
        case latitude
    }
}

// City Destinations Model
struct CityDestinationsResponse: Decodable {
    let data: DestinationsType
}

struct DestinationsType: Decodable {
    let attraction: [CityDestination]?
    let spot: [CityDestination]?
}

struct CityDestination: Decodable {
    let id: Int
    let name, poster, category, longitude, latitude: String
    let rate: String?
}


// City Ten Destinations Model
struct CityTenItemsResponse: Decodable {
    let data: [CityItems]
}

struct CityItems: Decodable {
    let id: Int
    let name, poster, category: String
}







