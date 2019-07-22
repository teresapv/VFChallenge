//
//  RepositoryControllerTest.swift
//  VFChallengeTPVTests
//
//  Created by Teresa on 22/07/2019.
//  Copyright © 2019 Teresa. All rights reserved.
//

import XCTest
@testable import VFChallengeTPV

class RepositoryControllerTests: XCTestCase {
    func testRequestRepositoriesWithoutResults() {
        // Given
        let apiMock = APIMock<[Repository]>()
        apiMock.response = nil
        let repositoryController = RepositoryController(apiClient: apiMock)
        
        // Then
        repositoryController.fechRepositories(matching: "Apple", page: 0) { result in
            XCTAssertNil(result)
        }
    }
    
    func testRequestRepositoriesWithResults() {
        // Given
        let apiMock = APIMock<[Repository]>()
        apiMock.response = [Repository(name: "Swift", author: "Apple", numberStars: 20000, numberForks: 400)]
        let repositoryController = RepositoryController(apiClient: apiMock)
        
        // Then
        repositoryController.fechRepositories(matching: "Apple", page: 0) { result in
            XCTAssertEqual(result?.count, 1)
            XCTAssertEqual(result?.first?.name, "Swift")
            XCTAssertEqual(result?.first?.author, "Apple")
            XCTAssertEqual(result?.first?.numberStars, 20000)
            XCTAssertEqual(result?.first?.numberForks, 400)
        }
    }
}

class APIMock<Response>: API {
    var response: Response? = nil
    
    func send<T: APIRequest>(_ request: T, completion: @escaping (T.Response?) -> Void) {
        if response == nil {
            completion(nil)
        } else {
            completion(response as! T.Response?)
        }
    }
}
