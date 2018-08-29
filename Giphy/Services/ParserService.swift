//
//  ParserService.swift
//  Giphy
//
//  Created by Viktar Semianchuk on 8/24/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ParserService {
    
    func parse(snapshot: DataSnapshot, completion: ([GiphyData]?) -> Swift.Void) {
        guard let snapshotValues = snapshot.values else {
            completion(nil)
            return
        }
        var results = [GiphyData]()
        let parser = JSONParser<GiphyData>()
        for value in snapshotValues {
            if let valueDictionary = value as? [String: Any], let data = try? JSONSerialization.data(withJSONObject: valueDictionary, options: []) {
                let result = parser.parse(data: data)
                if let validResult = result {
                    results.append(validResult)
                }
            }
        }
        completion(results)
    }
    
    func getExistingImage(_ giphyItem: GiphyData) -> UIImage {
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
}
