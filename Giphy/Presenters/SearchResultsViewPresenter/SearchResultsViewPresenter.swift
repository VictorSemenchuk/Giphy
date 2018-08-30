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
    @objc func fetchItems(_ searchRequest: String, with offset: Int, for collectionView: UICollectionView)
    @objc func setSearchRequest(_ searchRequest: String, by view: SearchResultsViewProtocol)
}

@objcMembers class SearchResultsViewPresenter: NSObject, CollectionViewPresenterProtocol, SearchResultsViewPresenterProtocol {
    
    //MARK:- Properties
    
    var items: [GiphyData]
    var searchRequest: String
    
    //MARK:- Public Methods
    
    override init() {
        self.searchRequest = String()
        self.items = [GiphyData]()
    }
    
    func fetchItems(_ searchRequest: String, with offset: Int, for collectionView: UICollectionView) {
        let giphyService = GiphyService()
        giphyService.fetchItemsBySearchRequest(searchRequest, with: offset) { (items, error) in
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
    
    func registerCells(for collectionView: UICollectionView) {
        collectionView.register(UINib(nibName: "GiphyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: kCollectionViewCellIdentifier)
    }
    
    func setSearchRequest(_ searchRequest: String, by view: SearchResultsViewProtocol) {
        self.searchRequest = searchRequest
        view.setViewTitle(searchRequest)
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
    
}
