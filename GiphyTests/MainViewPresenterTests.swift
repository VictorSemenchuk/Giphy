
//
//  MainViewPresenterTests.swift
//  GiphyTests
//
//  Created by Victor Macintosh on 30/08/2018.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

import XCTest
@testable import Giphy

class MainViewPresenterTests: XCTestCase {
    
    var giphyDataMock: GiphyData!
    
    override func setUp() {
        super.setUp()
        var urlPreview = "https://media1.giphy.com/media/14SAx6S02Io1ThOlOY/giphy-preview.gif?cid=e1bb72ff5b827be16c61305463455342"
        let urlOriginal = "https://media1.giphy.com/media/14SAx6S02Io1ThOlOY/giphy.gif?cid=e1bb72ff5b827be16c61305463455342"
        let metaPreview = GiphyImageMeta(url: urlPreview, size: "47815", width: "130", height: "73")
        let metaOriginal = GiphyImageMeta(url: urlOriginal, size: "1536071", width: "480", height: "270")
        let image = GiphyImage(original: metaOriginal, preview: metaPreview)
        giphyDataMock = GiphyData(values: ["dataId": "14SAx6S02Io1ThOlOY",
                                           "title": "money old people GIF by MOST EXPENSIVEST",
                                           "rating": "pg",
                                           "importDatetime": "2018-08-24 20:20:20",
                                           "trendingDatetime": "2018-08-25 22:22:04",
                                           "image": image])
    }
    
    override func tearDown() {
        giphyDataMock = nil
        super.tearDown()
    }
    
    func test_init_success() {
        let presenter = MainViewPresenter()
        XCTAssertNotNil(presenter, "Init can't return nil")
    }
    
    func test_fetchPreviewImage_success() {
        let presenter = MainViewPresenter()
        var result: UIImage?
        let expectation = self.expectation(description: "test_fetchPreviewImage_success")
        
        presenter.fetchPreviewImageForGiphyItem(giphyDataMock) { (image) in
            result = image
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
        
        XCTAssertNotNil(result, "Result can't be nil for valid url")
    }
    
    func test_fetchPreviewImage_failure() {
        let presenter = MainViewPresenter()
        giphyDataMock.image?.preview?.url = ""
        var result: UIImage?
        let expectation = self.expectation(description: "test_fetchPreviewImage_failure")
        
        presenter.fetchPreviewImageForGiphyItem(giphyDataMock) { (image) in
            result = image
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
        
        XCTAssertNil(result, "Result should be nil for invalid url")
    }
    
}
