//
//  FetchRepositoriesRequest.swift
//  VFChallengeTPV
//
//  Created by Teresa on 22/07/2019.
//  Copyright © 2019 Teresa. All rights reserved.
//

import Foundation

struct FetchRepositoriesRequest: APIRequest {
    typealias Response = [Repository]
    
    let path: String
    let page: Int
    
    init(author: String, page: Int) {
        self.path = "/users/" + author + "/repos?"
        self.page = page
    }
}
