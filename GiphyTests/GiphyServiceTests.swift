//
//  GiphyServiceTests.swift
//  GiphyTests
//
//  Created by Viktar Semianchuk on 8/24/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

import XCTest
@testable import Giphy

class GiphyServiceTests: XCTestCase {
    
    func test_fetchTrends_success() {
        let giphyService = GiphyService()
        let expectation = self.expectation(description: "test_fetchTrends_success")
        var results: [GiphyData]?
        
        giphyService.fetchTrends(with: 0, limit: 1) { (data, error) in
            results = data
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
        
        XCTAssertNotNil(results, "Result of fetching can't be nil")
    }
    
    func test_fetchItemsBySearchRequest_success() {
        let giphyService = GiphyService()
        let expectation = self.expectation(description: "test_fetchItemsBySearchRequest_success")
        var results: [GiphyData]?
        
        giphyService.fetchItemsBySearchRequest("", with: 1, limit: 1) { (data, error) in
            results = data
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
        
        XCTAssertNotNil(results, "Result of fetching can't be nil")
    }
    
}
