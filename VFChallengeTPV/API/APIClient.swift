//
//  APIClient.swift
//  VFChallengeTPV
//
//  Created by Teresa on 21/07/2019.
//  Copyright © 2019 Teresa. All rights reserved.
//

import Foundation

protocol APIRequest {
    associatedtype Response: Decodable
    
    var path: String { get }
    var page: Int { get }
}

protocol API {
    func send<T: APIRequest>(_ request: T, completion: @escaping (T.Response?) -> Void)
}

class APIClient: API {
    func send<T: APIRequest>(_ request: T, completion: @escaping (T.Response?) -> Void) {
        let task = URLSession.shared.dataTask(with: getGithubUrl(path: request.path, page: request.page)) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            
            if let error = error {
                print(error)
                completion(nil)
            } else {
                guard let data = data else {
                    print("Data is nill")
                    completion(nil)
                    return
                }
                guard let storeItems = try? jsonDecoder.decode(T.Response.self, from: data) else {
                    print("Fail to decode JSON data")
                    completion(nil)
                    return
                }
                completion(storeItems)
            }
        }
        task.resume()
    }
}

