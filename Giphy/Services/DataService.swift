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
    
    @objc public func getAnimatedPreviewImageFor(giphyData: GiphyData, completion: @escaping (UIImage?) -> Void) {
        let fileManager = GiphyFileManager()
        let data = fileManager.dataFromFileWithName(giphyData.dataId!, withType: .gif, from: .cache)
        if let data = data {
            completion(UIImage.animatedImage(data: data))
        } else {
            let downloadManager = DownloadManager()
            downloadManager.fetchData(fromURL: giphyData.image?.preview?.url) { (data) in
                if let data = data {
                    giphyData.image?.preview?.image = data
                    fileManager.writeFileWithName(giphyData.dataId!, data: data, withType: .gif, to: .cache)
                    completion(UIImage.animatedImage(data: data))
                } else {
                    completion(nil)
                }
            }
        }
    }
    
    @objc public func getAnimatedOriginalImageFor(giphyData: GiphyData, completion: @escaping (UIImage?) -> Void) {
        let downloadManager = DownloadManager()
        print(giphyData.image?.original?.url)
        downloadManager.fetchData(fromURL: giphyData.image?.original?.url) { (data) in
            if let data = data {
                giphyData.image?.original?.image = data
                completion(UIImage.animatedImage(data: data))
            } else {
                completion(nil)
            }
        }
    }
    
}
