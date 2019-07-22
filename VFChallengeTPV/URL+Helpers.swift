//
//  URL+Helpers.swift
//  VFChallengeTPV
//
//  Created by Teresa on 18/07/2019.
//  Copyright © 2019 Teresa. All rights reserved.
//

import Foundation

extension URL {
    func withQueries(_ queries: [String: String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.compactMap { URLQueryItem(name: $0.0, value: $0.1) }
        return components?.url
    }
}

let baseURL = "https://api.github.com"

func getGithubUrl(path: String, page: Int) -> URL {
    let query = [
        "page": String(page)
    ]
    guard let url = URL(string: (baseURL + path))?.withQueries(query) else {
        fatalError("Unable to build URL with supplied queries.")
    }
    return url
}

func getUrlSession(user: String, password: String) -> URLSession {
    let userPasswordString = "\(user):\(password)"
    let userPasswordData = userPasswordString.data(using: String.Encoding.utf8)
    let base64EncodedCredential = userPasswordData?.base64EncodedString()
    let authString = "Basic \(base64EncodedCredential ?? "")"
    
    let config = URLSessionConfiguration.default
    config.httpAdditionalHeaders = ["Authorization" : authString]
    return URLSession(configuration: config)
}

