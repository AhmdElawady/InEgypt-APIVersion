//
//  Service.swift
//  InEgypt
//
//  Created by Awady on 5/21/21.
//  Copyright © 2021 AwadyStore. All rights reserved.
//

import Foundation

class GenaricNetworking {
    
    func getRequest<T: Decodable>(urlString: String, completion: @escaping (T?, Error?) -> ()) {
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                completion(nil, error)
                return
            }
            do {
                let decoder = JSONDecoder()
                let object = try decoder.decode(T.self, from: data)
                completion(object, nil)
            } catch {
                completion(nil, error)
                print("Failed to decode Data:", error)
            }
        }
        task.resume()
    }
    
    func postRequest<T: Decodable>(request: URLRequest, completion: @escaping (T?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion(nil, error)
                return
            }
            do {
                let decoder = JSONDecoder()
                let object = try decoder.decode(T.self, from: data)
                completion(object, nil)
            } catch {
                completion(nil, error)
                print("Failed to decode Data:", error)
            }
        }
        task.resume()
    } 
}
