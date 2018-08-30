//
//  DownloadManagerTests.swift
//  GiphyTests
//
//  Created by Victor Macintosh on 30/08/2018.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

import XCTest
@testable import Giphy

class DownloadManagerTests: XCTestCase {
    
    func test_fetchDataFromURL_success() {
        let downloadManager = DownloadManager()
        let url = "https://api.giphy.com/v1/gifs/trending?api_key=dc6zaTOxFJmzC&limit=1"
        let expectation = self.expectation(description: "test_fetchDataFromURL_success")
        
        var results: Data?
        downloadManager.fetchData(fromURL: url) { (data, error) in
            results = data
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
        
        XCTAssertNotNil(results, "Data from valid URL can't be nil")
    }
    
    func test_fetchDataFromURL_failure() {
        let downloadManager = DownloadManager()
        let url = ""
        let expectation = self.expectation(description: "test_fetchDataFromURL_failure")
        
        var results: Data?
        downloadManager.fetchData(fromURL: url) { (data, error) in
            results = data
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
        
        XCTAssertNil(results, "Data from invalid URL should be nil")
    }
    
}
