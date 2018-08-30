//
//  DetailsViewPresenterTests.swift
//  GiphyTests
//
//  Created by Victor Macintosh on 30/08/2018.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

import XCTest
@testable import Giphy

class DetailsViewPresenterTests: XCTestCase {
    
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
        giphyDataMock = nil
        super.tearDown()
    }
    
    func test_init_success() {
        let presenter = DetailsViewPresenter(with: giphyDataMock)
        XCTAssertNotNil(presenter, "Init can't resturn nil")
    }
    
    func test_fetchOriginalImage_failure() {
        giphyDataMock.image?.original?.url = ""
        let presenter = DetailsViewPresenter(with: giphyDataMock)
        var result: UIImage?
        let expectation = self.expectation(description: "test_fetchPreviewImage_failure")
        
        presenter.fetchOriginalImageForItem(giphyDataMock) { (image) in
            result = image
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
        
        XCTAssertNil(result, "Result should be nil for invalid url")
    }
    
    func test_convertDate_success() {
        let presenter = DetailsViewPresenter(with: giphyDataMock)
        let result = presenter.convertDate(inputDate: "2018-08-24 20:20:20")
        XCTAssertEqual(result, "24 Aug 2018")
    }
    
    func test_convertDate_failure() {
        let presenter = DetailsViewPresenter(with: giphyDataMock)
        let result = presenter.convertDate(inputDate: "08-24-2018 20:20:20")
        XCTAssertNotEqual(result, "24 Aug 2018")
    }
    
}
