//
//  FullGif+extensions.swift
//  Giphy
//
//  Created by Pavel Koka on 8/28/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

import Foundation
import CoreData

extension FullGif {
    
    static public func saveFullGif(_ context: NSManagedObjectContext, _ newGiphy:GifPreview , _ giphyItem: GiphyData) {
        newGiphy.fullGif = FullGif(context: context)
        newGiphy.fullGif?.height = giphyItem.image?.original?.height
        newGiphy.fullGif?.width = giphyItem.image?.original?.width
        newGiphy.fullGif?.size = giphyItem.image?.original?.size
        newGiphy.fullGif?.url = giphyItem.image?.original?.url
        
//        let downloadManager = DownloadManager()
//        downloadManager.fetchData(fromURL: giphyItem.image?.original?.url, withCompletionBlock: { (fullImageData) in
            newGiphy.fullGif?.image = giphyItem.image?.original?.image
                do {
                    print("!!!!!!!!!!!!SAVED!!!!!!!!!!!!!")
                    try context.save()
                } catch {
                    print("Failed saving")
                }

//        })
    }
    
}
