//
//  SearchResultViewPresenter.swift
//  Giphy
//
//  Created by Viktar Semianchuk on 8/27/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

import Foundation
import UIKit

@objc protocol SearchResultsViewPresenterDelegate {
    @objc func itemsWasFetched(_ items: [GiphyData]?);
    @objc func updateTitle(text: String);
}

@objc public class SearchResultsViewPresenter: NSObject {
    
    var view: SearchResultsViewPresenterDelegate!
    
    @objc init(view: SearchResultsViewPresenterDelegate) {
        self.view = view;
    }
    
    @objc public func fetchItemsBySearchRequest(_ searchRequest: String, with offset: Int) {
        let giphyService = GiphyService()
        giphyService.fetchItemsBySearchRequest(searchRequest, with: offset) { (items, error) in
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
    
    @objc public func setTitle(text: String) {
        self.view.updateTitle(text: text)
    }
    
}
