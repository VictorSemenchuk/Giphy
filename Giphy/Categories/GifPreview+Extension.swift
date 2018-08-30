//
//  GifPreview+extension.swift
//  Giphy
//
//  Created by Pavel Koka on 8/28/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

import Foundation
import UIKit
import CoreData

extension GifPreview {
    
    static public func saveToPersistance(_ giphyItem: GiphyData) {
        let appDelegate =  UIApplication.shared.delegate as? AppDelegate
        appDelegate?.persistentContainer .performBackgroundTask({ (context) in
            if (alreadyExists(context: context, giphyItem)){
                print("Error GifPreview+extension")
            } else{
                saveGif(context: context, giphyItem)
            }
        })
    }
    
    static func alreadyExists(context: NSManagedObjectContext, _ giphyItem: GiphyData) -> Bool {
        let request: NSFetchRequest<NSFetchRequestResult> = GifPreview.fetchRequest()
        request.predicate = NSPredicate(format: "dataId = %@", giphyItem.dataId!)
        return try! context.count(for: request) > 0
    }
    
    
    static func saveGif(context: NSManagedObjectContext, _ giphyItem: GiphyData){
        let newGiphy:GifPreview = GifPreview(context: context)
        
        newGiphy.dataId = giphyItem.dataId
        newGiphy.title = giphyItem.title
        newGiphy.rating = giphyItem.rating
        newGiphy.importDatetime = giphyItem.importDatetime
        newGiphy.trendingDatetime = giphyItem.trendingDatetime
        newGiphy.url = giphyItem.image?.preview?.url
        newGiphy.size = giphyItem.image?.preview?.size
        newGiphy.height = giphyItem.image?.preview?.height
        newGiphy.width = giphyItem.image?.preview?.width
        newGiphy.image = giphyItem.image?.preview?.image
            
        FullGif.saveFullGif(context, newGiphy, giphyItem)
    }
    
}

