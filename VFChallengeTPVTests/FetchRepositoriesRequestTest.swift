//
//  FetchRepositoriesRequestTest.swift
//  VFChallengeTPVTests
//
//  Created by Teresa on 22/07/2019.
//  Copyright © 2019 Teresa. All rights reserved.
//

import XCTest

@testable import VFChallengeTPV

class FetchRepositoriesRequestTests: XCTestCase {
    
    func testRequestInit() {
        // When
        let request = FetchRepositoriesRequest(author: "Apple", page: 0)
        
        // Then
        XCTAssertEqual(request.path, "/users/Apple/repos?")
        XCTAssertEqual(request.page, 0)
    }
}
