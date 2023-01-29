//
//  URLRouter.swift
//  InEgypt
//
//  Created by Awady on 6/2/21.
//  Copyright © 2021 AwadyStore. All rights reserved.
//

import Foundation

class URLRouter {
    
    static let baseUrl = "https://.com"
    
    static func localizedKey() -> String {
        var languageKey = "en"
        LocalizationManager.shared.getLanguage() == .arabic ? (languageKey = "ar") : (languageKey = "en")
        return languageKey
    }
    
    enum HomeEndPoints {
        case ads
        case categories
        case attractions
        case spots
        case around
        case mapAttraction
        case cities
        
        var stringValue: String {
            switch self {
            case .ads: return
                baseUrl + "/aaa/" + localizedKey()
            case .categories: return
                baseUrl + "/aaa/" + localizedKey()
            case .attractions: return
                baseUrl + "/aaa/" + localizedKey()
            case .spots: return
                baseUrl + "/aaa/" + localizedKey()
            case .around: return
                baseUrl + "/aaa/" + localizedKey()
            case .mapAttraction: return
                baseUrl + "/aaa/" + localizedKey()
            case .cities: return
                baseUrl + "/aaa/" + localizedKey()
            }
        }
    }
    
    enum DestinationEndPoints {
        case attractions
        case spots
        case searchDestination

        var stringValue: String {
            switch self {
            case .attractions: return
                baseUrl + "/aaa/" + localizedKey()
            case .spots: return
                baseUrl + "/aaa/" + localizedKey()
            case .searchDestination: return
                baseUrl + "/aaa/" + localizedKey()
            }
        }
    }
    
    enum DetailEndPoints {
        case info
        case activities
        case categories
        case gallary
        case review
        case addReview
        case likeUnlike

        var stringValue: String {
            switch self {
            case .info: return
                baseUrl + "/aaa/" + localizedKey()
            case .activities: return
                baseUrl + "/aaa/" + localizedKey()
            case .categories: return
                baseUrl + "/aaa/" + localizedKey()
            case .gallary: return
                baseUrl + "/aaa/"
            case .review: return
                baseUrl + "/aaa/"
            case .addReview: return
                baseUrl + "/aaa/"
            case .likeUnlike: return
                baseUrl + "/aaa/"
            }
        }
    }
    
    enum SectionEndPoints {
        case categories
        case activities
        case categoryPlaces
        case activityPlaces
        
        var stringValue: String {
            switch self {
            case .categories: return
                baseUrl + "/aaa/" + localizedKey()
            case .activities: return
                baseUrl + "/aaa/" + localizedKey()
            case .categoryPlaces: return
                baseUrl + "/aaa/" + localizedKey()
            case .activityPlaces: return
                baseUrl + "/aaa/" + localizedKey()
            }
        }
    }
    
    enum CityEndPoints {
        case cities
        case city
        case cityDestinations
        case cityAttractions
        case citySpots
        
        var stringValue: String {
            switch self {
            case .cities: return
                baseUrl + "/aaa/" + localizedKey()
            case .city: return
                baseUrl + "/aaa/" + localizedKey()
            case .cityDestinations: return
                baseUrl + "/aaa/" + localizedKey()
            case .cityAttractions: return
                baseUrl + "/aaa/" + localizedKey()
            case .citySpots: return
                baseUrl + "/aaa/" + localizedKey()
            }
        }
    }
    
    enum TripRequestEndPoints {
        case destinations
        case searched
        case addRequest
        
        var stringValue: String {
            switch self {
            case .destinations: return
                baseUrl + "/aaa/" + localizedKey()
            case .searched: return
                baseUrl + "/aaa/" + localizedKey()
            case .addRequest: return
                baseUrl + "/aaa/"
            }
        }
    }
}
