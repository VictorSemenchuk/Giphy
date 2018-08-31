//
//  MainViewPresenter+CollectionView.swift
//  Giphy
//
//  Created by Victor Macintosh on 29/08/2018.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

import UIKit

extension MainViewPresenter: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource(showingSavedItemsStatus: self.showingSavedItems).count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCollectionViewCellIdentifier, for: indexPath) as! GiphyCollectionViewCell
        cell.backgroundColor = UIColor.randomTheme()
        
        let item = dataSource(showingSavedItemsStatus: self.showingSavedItems)[indexPath.row]
        if (self.showingSavedItems) {
            cell.imageView.image = UIImage.animatedImage(data: (item.image?.preview?.image)!)
            cell.stopActivityIndicator()
        } else {
            if (indexPath.row == dataSource(showingSavedItemsStatus: self.showingSavedItems).count - 10) {
                self.fetchItems(with: indexPath.row + 10, for: collectionView, by: nil)
            }
            self.fetchPreviewImageForGiphyItem(item) { (image) in
                cell.imageView.image = image
                cell.stopActivityIndicator()
            }
        }
        
        return cell
    }
    
}
