//
//  GiphyDataTests.swift
//  GiphyTests
//
//  Created by Pavel Koka on 8/30/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

import XCTest
import CoreData
@testable import Giphy

class GiphyDataTests: XCTestCase {
    
    var giphyDataMock: GiphyData!
    
    
    override func setUp() {
        super.setUp()
        let urlPreview = "https://media1.giphy.com/media/14SAx6S02Io1ThOlOY/giphy-preview.gif?cid=e1bb72ff5b827be16c61305463455342"
        let urlOriginal = "https://media1.giphy.com/media/14SAx6S02Io1ThOlOY/giphy.gif?cid=e1bb72ff5b827be16c61305463455342"
        let metaPreview = GiphyImageMeta(url: urlPreview, size: "47815", width: "130", height: "73")
        let metaOriginal = GiphyImageMeta(url: urlOriginal, size: "1536071", width: "480", height: "270")
        let image = GiphyImage(original: metaOriginal, preview: metaPreview)
        giphyDataMock = GiphyData(values: [
            "dataId": "14SAx6S02Io1ThOlOY",
            "title": "money old people GIF by MOST EXPENSIVEST",
            "rating": "pg",
            "importDatetime": "2018-08-24 20:20:20",
            "trendingDatetime": "2018-08-25 22:22:04",
            "image": image])
        GifPreview.saveToPersistance(giphyDataMock)
    }
    
    override func tearDown() {
        
        PersistentService.deleteItem(giphyDataMock)
        giphyDataMock = nil
        super.tearDown()
    }
    
    func test_initWithGifPreview_sucess(){
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let backgroundContext = appDelegate?.persistentContainer.newBackgroundContext()

        let request: NSFetchRequest<GifPreview> = GifPreview.fetchRequest()
        request.predicate = NSPredicate(format: "dataId = %@", giphyDataMock.dataId!)
        
        let _:NSFetchRequest<FullGif> = FullGif.fetchRequest()

        var result:[GifPreview] = []
        do {
            result = (try backgroundContext?.fetch(request))!
        } catch {
            NSLog("My Error: %@", error as NSError)
        }
        
        let fullMOCWithData = result.first
        fullMOCWithData?.image = Data.init()
        fullMOCWithData?.fullGif?.image = Data.init()

        XCTAssertNotNil(GiphyData.init(with: fullMOCWithData!) , "initWithGifPreview Failure")
    }
 
}
