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
    
    @objc public func getAnimatedPreviewImageFor(giphyData: GiphyData, completion: @escaping (UIImage?, GiphyError?) -> Void) {
        let fileManager = GiphyFileManager()
        let data = fileManager.dataFromFileWithName(giphyData.dataId!, withType: .gif, from: .cache)
        if let data = data {
            giphyData.image?.preview?.image = data
            let animatedImage = UIImage.animatedImage(data: data)
            if let animatedImage = animatedImage {
                completion(animatedImage, nil)
            } else {
                completion(nil, GiphyError(code: .dataErrorFailureGetAnimatedImage))
            }
        } else {
            let downloadManager = DownloadManager()
            downloadManager.fetchData(fromURL: giphyData.image?.preview?.url) { (data, error) in
                if let data = data {
                    giphyData.image?.preview?.image = data
                    fileManager.writeFileWithName(giphyData.dataId!, data: data, withType: .gif, to: .cache)
                    let animatedImage = UIImage.animatedImage(data: data)
                    if let animatedImage = animatedImage {
                        completion(animatedImage, nil)
                    } else {
                        completion(nil, GiphyError(code: .dataErrorFailureGetAnimatedImage))
                    }
                } else {
                    completion(nil, error)
                }
            }
        }
    }
    
    @objc public func getAnimatedOriginalImageFor(giphyData: GiphyData, completion: @escaping (UIImage?, GiphyError?) -> Void) {
        let downloadManager = DownloadManager()
        downloadManager.fetchData(fromURL: giphyData.image?.original?.url) { (data, error) in
            if let data = data {
                giphyData.image?.original?.image = data
                let animatedImage = UIImage.animatedImage(data: data)
                if let animatedImage = animatedImage {
                    completion(animatedImage, nil)
                } else {
                    completion(nil, GiphyError(code: .dataErrorFailureGetAnimatedImage))
                }
            } else {
                completion(nil, error)
            }
        }
    }
    
}
