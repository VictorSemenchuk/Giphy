//
//  SearchResultsViewPresenter+CollectionView.swift
//  Giphy
//
//  Created by Victor Macintosh on 30/08/2018.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

import UIKit

extension SearchResultsViewPresenter: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCollectionViewCellIdentifier, for: indexPath) as! GiphyCollectionViewCell
        cell.backgroundColor = UIColor.randomTheme()
        
        let item = self.items[indexPath.row]
        
        if (indexPath.row == self.items.count - 10) {
            self.fetchItems(self.searchRequest, with: indexPath.row + 10, for: collectionView)
        }
        self.fetchPreviewImageForGiphyItem(item) { (image) in
            cell.imageView.image = image
            cell.stopActivityIndicator()
        }
        
        return cell
    }
    
}
