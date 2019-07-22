//
//  Repository.swift
//  VFChallengeTPV
//
//  Created by Teresa on 18/07/2019.
//  Copyright © 2019 Teresa. All rights reserved.
//

import Foundation
/**
 ### Repository
 
 A Repository represents one repository for a user
 */


struct Repository: Codable {
    var name: String
    var author: String
    var numberStars: Int
    var numberForks: Int
   
    enum Keys: String, CodingKey {
        case name = "name"
        case author = "full_name"
        case numberStars = "stargazers_count"
        case numberForks = "forks_count"
    }
    
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy:Keys.self)
        self.name = try valueContainer.decode(String.self, forKey: Keys.name)
        self.author = getFirstPartSubstring(with: try! valueContainer.decode(String.self, forKey: Keys.author), range: "/")
        self.numberStars = try valueContainer.decode(Int.self, forKey: Keys.numberStars)
        self.numberForks = try valueContainer.decode(Int.self, forKey: Keys.numberForks)
    }
    
    init(name: String, author: String, numberStars: Int, numberForks: Int) {
        self.name = name
        self.author = author
        self.numberStars = numberStars
        self.numberForks = numberForks
    }
}

