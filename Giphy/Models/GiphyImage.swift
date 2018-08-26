//
//  GiphyImage.swift
//  Giphy
//
//  Created by Viktar Semianchuk on 8/24/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

import Foundation

@objc public class GiphyImage: NSObject, Codable {
    var original: GiphyImageMeta?
    var preview: GiphyImageMeta?
    
    init(original: GiphyImageMeta, preview: GiphyImageMeta) {
        self.original = original
        self.preview = preview
    }
    
    enum CodingKeys: String, CodingKey {
        case original = "original"
        case preview = "preview_gif"
    }
}
