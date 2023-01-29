//
//  Home.swift
//  InEgypt
//
//  Created by Awady on 5/24/21.
//  Copyright © 2021 AwadyStore. All rights reserved.
//

import Foundation

// Ads Model
struct AdsResponse: Decodable {
    let data: [Ads]
}
struct Ads: Decodable {
    let id: Int
    let poster: String
    let title: String
    let content: String
}

// Category Model
struct CategoryResponse: Decodable {
    let data: [HomeCategory]
}
struct HomeCategory: Decodable {
    let id: Int
    let title, icon: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case icon = "poster"
    }
}

//Recommended Model
struct RecommendedResponse: Decodable {
    let data: [Recommended]
}
struct Recommended: Decodable {
    let id: Int
    let poster, title, city, longitude, latitude: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title = "name"
        case poster
        case city
        case longitude
        case latitude
    }
}

//Around Model
struct AroundResponse: Decodable {
    let data: [HomeAround]
}
struct HomeAround: Decodable {
    let id: Int
    let name, poster, type, latitude, longitude: String
    let distance: Double
}

struct MapAttractionsResponse: Decodable {
    let data: [MapAttraction]
}
struct MapAttraction: Decodable {
    let id: Int
    let name, latitude, longitude: String
}


//Cities Model
struct HomeCitiesResponse: Decodable {
    let data: [HomeCity]
}
struct HomeCity: Decodable {
    let id, attractionCount, spotCount: Int
    let title, poster: String
    
    enum CodingKeys: String, CodingKey {
        case attractionCount = "count_att"
        case spotCount = "count_spot"
        case id
        case title = "city"
        case poster
    }
}



// Coordinates Post object
struct CoordinatesPost: Codable {
    let latitude, longitude: String
    
    enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "long"
    }
}


