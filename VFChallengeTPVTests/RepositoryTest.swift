//
//  RepositoryTest.swift
//  VFChallengeTPVTests
//
//  Created by Teresa on 22/07/2019.
//  Copyright © 2019 Teresa. All rights reserved.
//

import XCTest
@testable import VFChallengeTPV

class RepositoryTest: XCTestCase {

    func testDecodingJsonRepository() {
        // When
        let repository = try! JSONDecoder().decode(Repository.self, from: repositoryData)
            
        // Then
        XCTAssertEqual(repository.name, "Swift")
        XCTAssertEqual(repository.author, "Apple")
        XCTAssertEqual(repository.numberStars, 20000)
        XCTAssertEqual(repository.numberForks, 400)
    }
        
    private let repositoryData = Data("""
    {
    "name" : "Swift",
    "full_name" : "Apple/",
    "stargazers_count" : 20000,
    "forks_count" : 400 }
    """.utf8)
}

