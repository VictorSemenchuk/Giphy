//
//  DetailsViewPresenter.swift
//  Giphy
//
//  Created by Viktar Semianchuk on 8/27/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

import Foundation
import UIKit
import Social

@objc protocol DetailsViewPresenterDelegate: class {
    @objc func setPlayIconForStopPlayButton();
    @objc func setStopIconForStopPlayButton();
    @objc func setSaveRemoveButtonFor(savingStatus: Bool)
}

@objc protocol DetailsViewPresenterProtocol: class {
    @objc func fetchOriginalImageForItem(_ giphyItem: GiphyData, completion: @escaping (UIImage?) -> Void)
    @objc func convertDate(inputDate: String) -> String
    @objc func shareItem(_ giphyItem: GiphyData, by view: DetailsViewProtocol)
    @objc func startStopPlaying(for imageView: UIImageView, by view: DetailsViewProtocol)
    @objc func setSavingStatus(_ status: Bool, by view: DetailsViewProtocol)
    @objc func toggleSavingStatus(by view: DetailsViewProtocol)
    @objc func saveItem(_ giphyItem: GiphyData)
    @objc func checkIfItemIsExists(_ giphyData: GiphyData) -> Bool
    @objc func getExistingImage(_ giphyItem: GiphyData) -> UIImage
    @objc func removeItem(_ giphyItem: GiphyData)
}

@objcMembers class DetailsViewPresenter: NSObject {
    
    //MARK:- Properties
    
    var giphyItem: GiphyData?
    var animatedImage: UIImage?
    @objc public var isSaved: Bool
    
    //MARK:- Methods
    
    init(with giphyItem: GiphyData) {
        self.giphyItem = giphyItem
        self.isSaved = false
    }
    
    internal func updateSaveRemoveButton(for status: Bool, by view: DetailsViewProtocol) {
        var title: String
        var image: UIImage
        if (status) {
            title = "Remove"
            image = UIImage(named: "RemoveIcon")!
        } else {
            title = "Save"
            image = UIImage(named: "FavoriteIcon")!
        }
        view.updateSaveRemoveButton(title, image: image)
    }

}
