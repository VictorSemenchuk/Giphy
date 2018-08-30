//
//  MainViewPresenter+CollectionViewPresenterProtocol.swift
//  Giphy
//
//  Created by Viktar Semianchuk on 8/30/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

import Foundation

extension MainViewPresenter: CollectionViewPresenterProtocol {
    
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
        collectionView.register(UINib(nibName: kCollectionViewCellIdentifier, bundle: nil), forCellWithReuseIdentifier: kCollectionViewCellIdentifier)
    }
    
}
