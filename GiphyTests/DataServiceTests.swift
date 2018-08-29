//
//  DataServiceTests.swift
//  GiphyTests
//
//  Created by Victor Macintosh on 26/08/2018.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

import XCTest
@testable import Giphy

class DataServiceTests: XCTestCase {
    
    var giphyDataMock: GiphyData!
    
    override func setUp() {
        super.setUp()
        let urlPreview = "https://media1.giphy.com/media/14SAx6S02Io1ThOlOY/giphy-preview.gif?cid=e1bb72ff5b827be16c61305463455342"
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
        super.tearDown()
    }
    
    func test_getAnimatedImage_success() {
        let dataService = DataService()
        let expectation = self.expectation(description: "test_getAnimatedImage_success")
        var resultImage: UIImage?
        dataService.getAnimatedPreviewImageFor(giphyData: giphyDataMock) { (image) in
            resultImage = image
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssert(resultImage != nil, "Image should be not nil")
    }
    
}
