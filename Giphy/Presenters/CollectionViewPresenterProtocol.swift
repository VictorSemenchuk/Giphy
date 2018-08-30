//
//  CollectionViewPresenterProtocol.swift
//  Giphy
//
//  Created by Victor Macintosh on 30/08/2018.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

import Foundation

@objc protocol CollectionViewPresenterProtocol: class {
    @objc func fetchPreviewImageForGiphyItem(_ giphyItem: GiphyData, completion: @escaping (UIImage?) -> Void)
    @objc func registerCells(for collectionView: UICollectionView)
}
