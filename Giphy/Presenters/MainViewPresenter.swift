//
//  MainViewPresenter.swift
//  Giphy
//
//  Created by Victor Macintosh on 26/08/2018.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

import Foundation
import UIKit

@objc protocol MainViewPresenterDelegate {
    @objc func itemsWasFetched(_ items: [GiphyData]?);
}

@objc public class MainViewPresenter: NSObject {
    
    var view: MainViewPresenterDelegate!
    
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
        dataService.getAnimatedImageFor(giphyData: giphyItem) { (image) in
            DispatchQueue.main.async {
                completion(image)
            }
        }
    }
}
