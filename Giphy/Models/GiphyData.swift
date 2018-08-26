//
//  GiphyData.swift
//  Giphy
//
//  Created by Viktar Semianchuk on 8/24/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

import Foundation

@objc public class GiphyData: NSObject, Codable {
    var dataId: String?
    var title: String?
    var rating: String?
    var importDatetime: String?
    var trendingDatetime: String?
    var image: GiphyImage?
    
    enum CodingKeys: String, CodingKey {
        case title, rating
        case dataId = "id"
        case importDatetime = "import_datetime"
        case trendingDatetime = "trending_datetime"
        case image = "images"
    }
}
