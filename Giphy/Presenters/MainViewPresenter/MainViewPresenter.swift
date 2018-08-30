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

@objc protocol MainViewPresenterProtocol: class {
    @objc func fetchItems(with offset: Int, for collectionView: UICollectionView)
    @objc func fetchSavedItems() -> [GiphyData]
    @objc func refetchSavedItems(for collectionView: UICollectionView)
    @objc func itemForIndexPath(_ indexPath: IndexPath) -> GiphyData?
    @objc func toggleShowingSavedItemsFlag(view: MainViewProtocol, for collectionView: UICollectionView) -> Bool;
}

@objcMembers class MainViewPresenter: NSObject {
    
    //MARK:- Properties
    
    var items: [GiphyData]
    var savedItems: [GiphyData]
    var showingSavedItems: Bool
    
    //MARK:- Methods
    
    override init() {
        items = [GiphyData]()
        savedItems = [GiphyData]()
        showingSavedItems = false
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
    
    internal func dataSource(showingSavedItemsStatus: Bool) -> [GiphyData] {
        return showingSavedItemsStatus ? self.savedItems : self.items
    }
    
}
