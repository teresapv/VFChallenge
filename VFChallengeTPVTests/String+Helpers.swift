//
//  String+Helpers.swift
//  VFChallengeTPVTests
//
//  Created by Teresa on 22/07/2019.
//  Copyright © 2019 Teresa. All rights reserved.
//

import XCTest
@testable import VFChallengeTPV

class String_Helpers: XCTestCase {

    func testFirstPartSubstring() {
        // Given
        let rawString = "returnThisSubstring/removeThisSubString"
        
        // When
        let resultString = getFirstPartSubstring(with: rawString, range: "/")
        
        // Then
        XCTAssertEqual(resultString, "returnThisSubstring")
    }
    
    func testFirstPartSubstringNotFound() {
        // Given
        let rawString = "returnThisSubstring/removeThisSubString"
        
        // When
        let resultString = getFirstPartSubstring(with: rawString, range: "*")
        
        // Then
        XCTAssertEqual(resultString, "")
    }
    
    func testLastPartSubstring() {
        // Given
        let rawString = "returnThisSubstring/removeThisSubString"
        
        // When
        let resultString = getLastPartSubstring(with: rawString, range: "/")
        
        // Then
        XCTAssertEqual(resultString, "removeThisSubString")
    }
    
    func testLastPartSubstringNotFound() {
        // Given
        let rawString = "returnThisSubstring/removeThisSubString"
        
        // When
        let resultString = getLastPartSubstring(with: rawString, range: "*")
        
        // Then
        XCTAssertEqual(resultString, "")
    }
}
