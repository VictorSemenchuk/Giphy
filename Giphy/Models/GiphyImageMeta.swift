//
//  GiphyImageMeta.swift
//  Giphy
//
//  Created by Viktar Semianchuk on 8/24/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

import Foundation

@objcMembers public class GiphyImageMeta: NSObject, Codable {
    var url: String?
    var size: String?
    var width: String?
    var height: String?
    var image: Data?
    
    init(url: String, size: String, width: String, height: String) {
        self.url = url
        self.size = size
        self.width = width
        self.height = height
    }
    
    convenience init(url: String, size: String, width: String, height: String, image: Data) {
        self.init(url: url, size: size, width: width, height: height)
        self.image = image
    }
}
