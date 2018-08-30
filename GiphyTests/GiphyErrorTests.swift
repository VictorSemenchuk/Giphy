//
//  GiphyErrorTests.swift
//  GiphyTests
//
//  Created by Viktar Semianchuk on 8/29/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

import XCTest
@testable import Giphy

class GiphyErrorTests: XCTestCase {
    
    func test_localizedDescriptionForErrorCode_success() {
        let inputErrorCode = GiphyErrorCode.downloadingError
        let inputError = GiphyError(code: inputErrorCode)
        
        let localizedDescription = inputError?.localizedDescription
        
        XCTAssertEqual(localizedDescription, "Downloading error")
    }

}
