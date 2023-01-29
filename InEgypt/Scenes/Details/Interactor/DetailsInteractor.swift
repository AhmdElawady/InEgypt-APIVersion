//
//  DetailsService.swift
//  InEgypt
//
//  Created by Awady on 5/27/21.
//  Copyright © 2021 AwadyStore. All rights reserved.
//

import UIKit

class DetailsInteractor {
    
    static let shared = DetailsInteractor()
    let genaricNetworking = GenaricNetworking()
    let token = UIDevice.current.identifierForVendor?.uuidString
    
    func fetchInfo(id: Int, completion: @escaping (InfoResponse?, Error?) -> Void) {
        let urlString = URL(string: URLRouter.DetailEndPoints.info.stringValue)!
        var request = URLRequest(url: urlString)
        request.httpMethod = "POST"
        request.addValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(token ?? "", forHTTPHeaderField: "token")
        request.httpBody = try! JSONEncoder().encode(["id": id])
        
        genaricNetworking.postRequest(request: request, completion: completion)
    }
    
    func fetchActivities(id: Int, completion: @escaping (PlaceSectionResponse?, Error?) -> Void) {
        let urlString = URL(string: URLRouter.DetailEndPoints.activities.stringValue)!
        var request = URLRequest(url: urlString)
        request.httpMethod = "POST"
        request.addValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONEncoder().encode(["id": id])
        
        genaricNetworking.postRequest(request: request, completion: completion)
    }
    
    func fetchCategories(id: Int, completion: @escaping (PlaceSectionResponse?, Error?) -> Void) {
        let urlString = URL(string: URLRouter.DetailEndPoints.categories.stringValue)!
        var request = URLRequest(url: urlString)
        request.httpMethod = "POST"
        request.addValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONEncoder().encode(["id": id])
        
        genaricNetworking.postRequest(request: request, completion: completion)
    }
    
    func fetchGallary(id: Int, completion: @escaping (GallaryResponse?, Error?) -> Void) {
        let urlString = URL(string: URLRouter.DetailEndPoints.gallary.stringValue)!
        var request = URLRequest(url: urlString)
        request.httpMethod = "POST"
        request.addValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONEncoder().encode(["id": id])
        
        genaricNetworking.postRequest(request: request, completion: completion)
    }
    
    func fetchReviews(id: Int, completion: @escaping (ReviewsResponse?, Error?) -> Void) {
        let urlString = URL(string: URLRouter.DetailEndPoints.review.stringValue)!
        var request = URLRequest(url: urlString)
        request.httpMethod = "POST"
        request.addValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONEncoder().encode(["id": id])
        
        genaricNetworking.postRequest(request: request, completion: completion)
    }
    
    func postAReview(body: ReviewBody, completion: @escaping (AddReviewResponse?, Error?) -> Void) {
        let urlString = URL(string: URLRouter.DetailEndPoints.addReview.stringValue)!
        var request = URLRequest(url: urlString)
        request.httpMethod = "POST"
        request.addValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(token ?? "", forHTTPHeaderField: "token")
        request.httpBody = try! JSONEncoder().encode(body)
        
        genaricNetworking.postRequest(request: request, completion: completion)
    }
    
    func postLikeUnlike(id: Int, completion: @escaping (LikeResponse?, Error?) -> Void) {
        let urlString = URL(string: URLRouter.DetailEndPoints.likeUnlike.stringValue)!
        var request = URLRequest(url: urlString)
        request.httpMethod = "POST"
        request.addValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(token ?? "", forHTTPHeaderField: "token")
        request.httpBody = try! JSONEncoder().encode(["id": id])
        
        genaricNetworking.postRequest(request: request, completion: completion)
    }
}
