//
//  PersistentService.swift
//  Giphy
//
//  Created by Viktar Semianchuk on 8/29/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class PersistentService {
    
    static func checkIfItemExists(_ giphyItem: GiphyData) -> Bool {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let backgroundContext = appDelegate?.persistentContainer.newBackgroundContext()
        
        let request: NSFetchRequest<NSFetchRequestResult> = GifPreview.fetchRequest()
        request.predicate = NSPredicate(format: "dataId = %@", giphyItem.dataId!)
        
        var result: Bool = false
        
        do {
            result = (try backgroundContext?.count(for: request))! > 0
        } catch {
            NSLog("My Error: %@", error as NSError)
        }
        
        return result
    }
    
    static func getExistingImage(_ giphyItem: GiphyData) -> UIImage {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let backgroundContext = appDelegate?.persistentContainer.newBackgroundContext()
        
        let request: NSFetchRequest<GifPreview> = GifPreview.fetchRequest()
        request.predicate = NSPredicate(format: "dataId = %@", giphyItem.dataId!)
        
        var result:[GifPreview] = []
        
        do {
            result = (try backgroundContext?.fetch(request))!
        } catch {
            NSLog("My Error: %@", error as NSError)
        }
        
        return UIImage.animatedImage(data: (result.first?.fullGif?.image)!)!
    }
    
    static func deleteItem(_ giphyItem: GiphyData) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let backgroundContext = appDelegate?.persistentContainer.newBackgroundContext()
        
        let request: NSFetchRequest<GifPreview> = GifPreview.fetchRequest()
        request.predicate = NSPredicate(format: "dataId = %@", giphyItem.dataId!)
        
        var result:[GifPreview] = []
        
        do {
            result = (try backgroundContext?.fetch(request))!
        } catch {
            NSLog("My Error: %@", error as NSError)
        }
        
        backgroundContext?.delete(result.first!)
        
        do {
            try backgroundContext?.save()
        } catch {
            NSLog("My Error: %@", error as NSError)
        }
    }
    
}
