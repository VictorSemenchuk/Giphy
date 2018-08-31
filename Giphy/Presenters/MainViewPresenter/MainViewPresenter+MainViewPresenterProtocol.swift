//
//  MainViewPresenter+MainViewPresenterProtocol.swift
//  Giphy
//
//  Created by Viktar Semianchuk on 8/30/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

import Foundation
import CoreData

extension MainViewPresenter: MainViewPresenterProtocol {
    
    func fetchItems(with offset: Int, for collectionView: UICollectionView, by view: FetchViewProtocol?) {
        let giphyService = GiphyService()
        view?.startActivityIndicator()
        giphyService.fetchTrends(with: offset, limit: Int(kFetchingAmountLimit)) { (items, error) in
            if let error = error {
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    view?.stopActivityIndicator()
                    view?.showMessageLabelWithText(error.localizedDescription)
                }
            } else {
                DispatchQueue.main.async {
                    let indexPaths = self.itemsWasFetched(items!)
                    view?.stopActivityIndicator()
                    collectionView.insertItems(at: indexPaths)
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
    
    func itemForIndexPath(_ indexPath: IndexPath) -> GiphyData? {
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
    
}
