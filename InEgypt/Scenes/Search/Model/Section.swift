//
//  Category.swift
//  InEgypt
//
//  Created by Awady on 8/7/20.
//  Copyright © 2020 AwadyStore. All rights reserved.
//

import Foundation

// Section Model
struct SectionResponse: Decodable {
    let data: [Section]
}
struct Section: Decodable {
    let id: Int
    let title: String
    let poster: String
}

// Section Destinations Model
struct SectionDestinationsResponse: Decodable {
    let data: [SectionDestinations]?
}
struct SectionDestinations: Decodable {
    let id: Int
    let name, poster, city, latitude, longitude: String
    let rate: String?
}
