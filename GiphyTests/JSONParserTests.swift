//
//  JSONParserTests.swift
//  GiphyTests
//
//  Created by Victor Macintosh on 30/08/2018.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

import XCTest
@testable import Giphy

class JSONParserTests: XCTestCase {
    
    func test_parse_success() {
        let expectation = self.expectation(description: "test_parse_success")
        let url = "https://api.giphy.com/v1/gifs/trending?api_key=dc6zaTOxFJmzC&limit=1"
        let downloadManager = DownloadManager()
        let expectedValue = DataSnapshot()
        var result: [GiphyData]?
        
        downloadManager.fetchData(fromURL: url) { (data, error) in
            expectedValue.values = expectedValue.setValuesBy(data: data!)
            let parserService = ParserService()
            parserService.parse(snapshot: expectedValue) { (data, error) in
                result = data
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 10, handler: nil)
        
        XCTAssertNotNil(result, "Data can't be nil for valid snapshot")
        
    }
    
    func test_parse_failure() {
        let parserService = ParserService()
        var result: [GiphyData]?
        
        parserService.parse(snapshot: DataSnapshot()) { (data, error) in
            result = data
        }
        
        XCTAssertNil(result, "Data should be nil for invalid input data")
    }
    
}
