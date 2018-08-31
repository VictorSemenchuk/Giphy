//
//  SearchResultViewPresenter.swift
//  Giphy
//
//  Created by Viktar Semianchuk on 8/27/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

import Foundation
import UIKit

@objc protocol SearchResultsViewPresenterProtocol: class {
    @objc func fetchItems(_ searchRequest: String, with offset: Int, for collectionView: UICollectionView, by view: FetchViewProtocol?)
    @objc func setSearchRequest(_ searchRequest: String, by view: SearchResultsViewProtocol)
}

@objcMembers class SearchResultsViewPresenter: NSObject {
    
    //MARK:- Properties
    
    var items: [GiphyData]
    var searchRequest: String
    
    //MARK:- Methods
    
    override init() {
        self.searchRequest = String()
        self.items = [GiphyData]()
    }
    
    internal func itemsWasFetched(_ items: [GiphyData]) -> ([IndexPath]) {
        let section = 0
        var indexPaths = [IndexPath]()
        for i in 0..<items.count {
            let item = items[i]
            if item.image?.preview?.height != "" && item.image?.preview?.width != "" {
                self.items .append(item)
                let row = self.items.count - 1
                let indexPath = IndexPath(row: row, section: section)
                indexPaths.append(indexPath)
            }
        }
        return indexPaths
    }
    
}
