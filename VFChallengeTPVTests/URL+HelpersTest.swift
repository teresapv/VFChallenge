//
//  URL+HelpersTest.swift
//  VFChallengeTPVTests
//
//  Created by Teresa on 21/07/2019.
//  Copyright © 2019 Teresa. All rights reserved.
//

import XCTest
@testable import VFChallengeTPV

class URL_HelpersTest: XCTestCase {
    
    func testGetUrlWithPage() {
        // Given
        let path = "/test"
        let page = 2
        
        // When
        let url = getGithubUrl(path: path, page: page)
        
        // Then
        XCTAssertEqual(url.absoluteString, "https://api.github.com/test?page=2")
    }
    
    func testAuthorizationHeaders(){
        // Given
        let user = "teresapv"
        let pass = "teresa"
        
        // When
        let urlSession = getUrlSession(user: user, password: pass)
        
        // Then
        XCTAssertEqual(urlSession.configuration.httpAdditionalHeaders!["Authorization"] as! String, "Basic dGVyZXNhcHY6dGVyZXNh")
    }
}
