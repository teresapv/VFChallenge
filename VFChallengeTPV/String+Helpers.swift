//
//  String+Helpers.swift
//  VFChallengeTPV
//
//  Created by Teresa on 22/07/2019.
//  Copyright © 2019 Teresa. All rights reserved.
//

import Foundation

func getLastPartSubstring(with longString: String, range: String) -> (String) {
    let lastPagePath = longString
    if let range = lastPagePath.range(of: range) {
        let substringNumberPag = lastPagePath[range.upperBound ..< lastPagePath.endIndex] // find number of the last page
        return String (substringNumberPag)
    }
    return ""
}

func getFirstPartSubstring(with longString: String, range: String) -> (String) {
    let lastPagePath = longString
    if let range = longString.range(of: range) {
        let substringNumberPag = lastPagePath[lastPagePath.startIndex ..<  range.lowerBound ] // find number of the last page
        return String (substringNumberPag)
    }
    return ""
}
