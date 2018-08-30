//
//  SearchResultsViewPresenter+SearchResultsViewPresenterProtocol.swift
//  Giphy
//
//  Created by Viktar Semianchuk on 8/30/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

import Foundation

extension SearchResultsViewPresenter: SearchResultsViewPresenterProtocol {
    
    func fetchItems(_ searchRequest: String, with offset: Int, for collectionView: UICollectionView) {
        let giphyService = GiphyService()
        giphyService.fetchItemsBySearchRequest(searchRequest, with: offset, limit: Int(kFetchingAmountLimit)) { (items, error) in
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
    
    func setSearchRequest(_ searchRequest: String, by view: SearchResultsViewProtocol) {
        self.searchRequest = searchRequest
        view.setViewTitle(searchRequest)
    }
    
}
