//
//  CategoriesService.swift
//  InEgypt
//
//  Created by Awady on 6/1/21.
//  Copyright © 2021 AwadyStore. All rights reserved.
//

import Foundation

class SectionsService {
    
    static let shared = SectionsService()
    let genaricNetworking = GenaricNetworking()
    
    func fetchCategory(completion: @escaping (SectionResponse?, Error?) -> Void) {
        let urlString = URLRouter.SectionEndPoints.categories.stringValue
        genaricNetworking.getRequest(urlString: urlString, completion: completion)
    }
    
    func fetchActivity(completion: @escaping (SectionResponse?, Error?) -> Void) {
        let urlString = URLRouter.SectionEndPoints.activities.stringValue
        genaricNetworking.getRequest(urlString: urlString, completion: completion)
    }
    
    func fetchCategoryPlaces(id: Int, completion: @escaping (SectionDestinationsResponse?, Error?) -> Void) {
        let urlString = URL(string: URLRouter.SectionEndPoints.categoryPlaces.stringValue)!
        var request = URLRequest(url: urlString)
        request.httpMethod = "POST"
        request.addValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONEncoder().encode(["id": id])
        
        genaricNetworking.postRequest(request: request, completion: completion)
    }
    
    func fetchActivityPlaces(id: Int, completion: @escaping (SectionDestinationsResponse?, Error?) -> Void) {
        let urlString = URL(string: URLRouter.SectionEndPoints.activityPlaces.stringValue)!
        var request = URLRequest(url: urlString)
        request.httpMethod = "POST"
        request.addValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONEncoder().encode(["id": id])
        
        genaricNetworking.postRequest(request: request, completion: completion)
    }
}
