//
//  MainViewPresenter.swift
//  Giphy
//
//  Created by Victor Macintosh on 26/08/2018.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

import Foundation
import UIKit
import CoreData

@objc protocol MainViewPresenterDelegate: class {
    @objc func itemsWasFetched(_ items: [GiphyData]?);
}


@objc public class MainViewPresenter: NSObject {
    
    weak var view: MainViewPresenterDelegate!
    
    @objc init(view: MainViewPresenterDelegate) {
        self.view = view
    }
    
    @objc public func fetchItems(with offset: Int) {
        let giphyService = GiphyService()
        giphyService.fetchTrends(with: offset) { (items, error) in
            if error == .NoError {
                DispatchQueue.main.async {
                    self.view.itemsWasFetched(items)
                }
            }
        }
    }
    
    @objc public func fetchPreviewImageForGiphyItem(_ giphyItem: GiphyData, completion: @escaping (UIImage?) -> Void) {
        let dataService = DataService()
        dataService.getAnimatedPreviewImageFor(giphyData: giphyItem) { (image) in
            DispatchQueue.main.async {
                completion(image)
            }
        }
    }
    
    @objc public func showSaved() -> [GiphyData] {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let context:NSManagedObjectContext = (appDelegate?.persistentContainer.newBackgroundContext())!
        let fetchRequest:NSFetchRequest<GifPreview> = GifPreview.fetchRequest()
        var temp:[GifPreview] = []
        do {
            temp = try context.fetch(fetchRequest)
            } catch {
                print("My Error: %@", error as NSError)
        }
        
        var result:[GiphyData] = []
        
            for gifPreview in temp {
                result.append(GiphyData.init(with: gifPreview))
            }
        
        return result
        }
    
    
    
}
