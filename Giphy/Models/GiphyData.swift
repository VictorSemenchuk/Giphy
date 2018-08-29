//
//  GiphyData.swift
//  Giphy
//
//  Created by Viktar Semianchuk on 8/24/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

import Foundation

@objcMembers public class GiphyData: NSObject, Codable {
    var dataId: String?
    var title: String?
    var rating: String?
    var importDatetime: String?
    var trendingDatetime: String?
    var image: GiphyImage?
    
    init(values: [String: Any]) {
        self.dataId = values["dataId"] as? String
        self.title = values["title"] as? String
        self.rating = values["rating"] as? String
        self.importDatetime = values["importDatetime"] as? String
        self.trendingDatetime = values["trendingDatetime"] as? String
        self.image = values["image"] as? GiphyImage
    }
    
    init(with cdItem:GifPreview) {
        self.dataId = cdItem.dataId
        self.title = cdItem.title
        self.rating = cdItem.rating
        self.importDatetime = cdItem.importDatetime
        self.trendingDatetime = cdItem.trendingDatetime
        
        let preview = GiphyImageMeta(url: cdItem.url!, size: cdItem.size!, width: cdItem.width!, height: cdItem.height!, image: cdItem.image!)
        let original = GiphyImageMeta(url: (cdItem.fullGif?.url)!, size: (cdItem.fullGif?.size)!, width: (cdItem.fullGif?.width)!, height: (cdItem.fullGif?.height)!, image: (cdItem.fullGif?.image)!)
        
        self.image = GiphyImage(original: original, preview: preview)
    }
    
    enum CodingKeys: String, CodingKey {
        case title, rating
        case dataId = "id"
        case importDatetime = "import_datetime"
        case trendingDatetime = "trending_datetime"
        case image = "images"
    }
}
