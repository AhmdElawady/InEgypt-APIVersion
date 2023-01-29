//
//  DestinationDetails.swift
//  InEgypt
//
//  Created by Awady on 5/29/21.
//  Copyright © 2021 AwadyStore. All rights reserved.
//

import Foundation

// DestinationsInfo Model
struct InfoResponse: Decodable {
    let data: Info
}

struct Info: Decodable {
    let like: Int
    let poster, title, type, city, longitude, latitude, description, from, to: String
    let ticketsPrice: Ticket?
    let address: String?
    
    enum CodingKeys: String, CodingKey {
        case like
        case title = "name"
        case poster
        case type
        case city
        case address
        case longitude
        case latitude
        case from
        case to
        case description
        case ticketsPrice = "ticket_price"
    }
}
struct Ticket: Decodable {
    let students, egyptions, foreign, foreignStudents, caption: String?
}

// Gallary Model
struct GallaryResponse: Decodable {
    let data: [ImageData]
}
struct ImageData: Decodable {
    let image: String
    
    enum CodingKeys: String, CodingKey {
        case image = "img"
    }
}

// Review Model
struct ReviewsResponse: Decodable {
    let data: ReviewsInfo
}
struct ReviewsInfo: Decodable {
    let count: Int
    let avg: String?
    let review: [Review]?
}
struct Review: Decodable {
    let username: String
    let date: String
    let rate: String
    let review: String
}

// AddReview Model
struct AddReviewResponse: Decodable {
    let status: Int
    let msg: String
}

// Like Response
struct LikeResponse: Decodable {
    let status: Int
    let msg: String
}

// Section Model
struct PlaceSectionResponse: Decodable {
    let data: [PlaceSection]
}
struct PlaceSection: Decodable {
    let id: Int
    let title, poster: String
}

// ReviewBody Post Model
struct ReviewBody: Codable {
    let id: Int
    let username: String
    let rate: Int
    let review: String
}

