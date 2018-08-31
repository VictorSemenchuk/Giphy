//
//  SearchResultsViewPresenter+SearchResultsViewPresenterProtocol.swift
//  Giphy
//
//  Created by Viktar Semianchuk on 8/30/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

import Foundation

extension SearchResultsViewPresenter: SearchResultsViewPresenterProtocol {
    
    func fetchItems(_ searchRequest: String, with offset: Int, for collectionView: UICollectionView, by view: FetchViewProtocol?) {
        let giphyService = GiphyService()
        view?.startActivityIndicator()
            giphyService.fetchItemsBySearchRequest(searchRequest.trimmingCharacters(in: .whitespaces), with: offset, limit: Int(kFetchingAmountLimit)) { (items, error) in
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
                    if (items?.count == 0) {
                        view?.showMessageLabelWithText("No results")
                    }
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
