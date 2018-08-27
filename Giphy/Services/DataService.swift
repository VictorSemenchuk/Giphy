//
//  DataService.swift
//  Giphy
//
//  Created by Victor Macintosh on 26/08/2018.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

import Foundation
import UIKit

@objc public class DataService: NSObject {
    
    @objc public func getAnimatedImageFor(giphyData: GiphyData, completion: @escaping (UIImage?) -> Void) {
        let fileManager = GiphyFileManager()
        let data = fileManager.dataFromFileWithName(giphyData.dataId!, withType: .gif, from: .cache)
        if let data = data {
            completion(UIImage.animatedImage(data: data))
        } else {
            let downloadManager = DownloadManager()
            downloadManager.fetchData(fromURL: giphyData.image?.preview?.url) { (data) in
                if let data = data {
                    fileManager.writeFileWithName(giphyData.dataId!, data: data, withType: .gif, to: .cache)
                    completion(UIImage.animatedImage(data: data))
                } else {
                    completion(nil)
                }
            }
        }
    }
    
}