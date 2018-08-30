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
    @objc func itemForIndexPath(_ indexPath: IndexPath) -> GiphyData
    @objc func toggleShowingSavedItemsFlag(view: MainViewProtocol, for collectionView: UICollectionView) -> Bool;
}

@objcMembers class MainViewPresenter: NSObject, CollectionViewPresenterProtocol, MainViewPresenterProtocol {
    
    //MARK:- Properties
    
    var items: [GiphyData]
    var savedItems: [GiphyData]
    var showingSavedItems: Bool
    
    //MARK:- Public Methods
    
    override init() {
        items = [GiphyData]()
        savedItems = [GiphyData]()
        showingSavedItems = false
    }
    
    func fetchItems(with offset: Int, for collectionView: UICollectionView) {
        let giphyService = GiphyService()
        giphyService.fetchTrends(with: offset) { (items, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                DispatchQueue.main.async {
                    let indexPaths = self.itemsWasFetched(items!)
                    collectionView.insertItems(at: indexPaths)
                }
            }
        }
    }
    
    func fetchPreviewImageForGiphyItem(_ giphyItem: GiphyData, completion: @escaping (UIImage?) -> Void) {
        let dataService = DataService()
        dataService.getAnimatedPreviewImageFor(giphyData: giphyItem) { (image, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                DispatchQueue.main.async {
                    completion(image)
                }
            }
        }
    }
    
    func fetchSavedItems() -> [GiphyData] {
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
    
    func refetchSavedItems(for collectionView: UICollectionView) {
        if self.showingSavedItems {
            self.savedItems = self.fetchSavedItems()
            collectionView.reloadData()
        }
    }
    
    func registerCells(for collectionView: UICollectionView) {
        collectionView.register(UINib(nibName: "GiphyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: kCollectionViewCellIdentifier)
    }
    
    func itemForIndexPath(_ indexPath: IndexPath) -> GiphyData {
        let items = dataSource(showingSavedItemsStatus: self.showingSavedItems)
        return items[indexPath.row]
    }
    
    func toggleShowingSavedItemsFlag(view: MainViewProtocol, for collectionView: UICollectionView) -> Bool {
        self.showingSavedItems = !self.showingSavedItems
        let imageName = self.showingSavedItems ? "TrendingIconLarge" : "FavoriteIcon"
        view.updateShowSavedButton(UIImage(named: imageName)!)
        if (!self.showingSavedItems) {
            self.savedItems.removeAll()
        } else {
            self.savedItems = self.fetchSavedItems()
        }
        collectionView.reloadData()
        return self.showingSavedItems;
    }
    
    //MARK:- Private Methods
    
    private func itemsWasFetched(_ items: [GiphyData]) -> ([IndexPath]) {
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
