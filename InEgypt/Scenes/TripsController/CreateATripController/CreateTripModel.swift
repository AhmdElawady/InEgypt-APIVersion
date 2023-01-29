//
//  CreateTrip.swift
//  InEgypt
//
//  Created by Awady on 6/3/21.
//  Copyright © 2021 AwadyStore. All rights reserved.
//

import Foundation


struct TripDataResponse: Decodable {
    let data: [TripDestination]
}

struct TripDestination: Decodable {
    let id: Int
    let name: String
}


struct TripSearchResponse: Decodable {
    let data: SearchedPlace?
}

struct SearchedPlace: Decodable {
    let id: Int
    let name: String
}


struct TripRequestBody: Codable {
    let destination: [Int]?
    let destination_name: [String]?
    let username: String
    let phone: String
    let token: String
    let adults: String
    let childs: String
    let room: String?
    let from_date: String
    let to_date: String
    let budget: String?
    let preferences: String?
    let beach: String?
    let aquaPark: String?
    let stars: String?
}

struct TripRequestResponse: Decodable {
    let status: Int
    let msg: String
}
