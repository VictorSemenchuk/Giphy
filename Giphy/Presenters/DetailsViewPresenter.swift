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

@objcMembers class DetailsViewPresenter: NSObject, DetailsViewPresenterProtocol {
    
    //MARK:- Properties
    
    var giphyItem: GiphyData?
    var animatedImage: UIImage?
    @objc public var isSaved: Bool
    
    //MARK:- Methods
    
    init(with giphyItem: GiphyData) {
        self.giphyItem = giphyItem
        self.isSaved = false
    }
    
    func fetchOriginalImageForItem(_ giphyItem: GiphyData, completion: @escaping (UIImage?) -> Void) {
        let dataService = DataService()
        dataService.getAnimatedOriginalImageFor(giphyData: giphyItem) { (image, error) in
            if let error = error {
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    completion(nil)
                }
            } else {
                DispatchQueue.main.async {
                    completion(image)
                }
            }
        }
    }
    
    func convertDate(inputDate: String) -> String {
        let date = Date.date(with: "yyyy-MM-dd HH:mm:ss", from: inputDate)
        if let date = date {
            return String.string(with: "dd MMM yyyy", from: date)
        } else {
            return ""
        }
    }
    
    func shareItem(_ giphyItem: GiphyData, by view: DetailsViewProtocol) {
        let activityViewController = UIActivityViewController(activityItems: [giphyItem.title!, giphyItem.image?.original?.url ?? "", giphyItem.image?.original?.image! as Any], applicationActivities: nil)
        view.show(activityViewController)
    }
    
    
    func startStopPlaying(for imageView: UIImageView, by view: DetailsViewProtocol) {
        if (self.animatedImage != nil) {
            imageView.image = self.animatedImage;
            self.animatedImage = nil
            view.setIconForStartStopPlayingButton(UIImage(named: "StopIcon"))
        } else {
            self.animatedImage = imageView.image
            imageView.image = nil;
            imageView.image = self.animatedImage?.images![0];
            view.setIconForStartStopPlayingButton(UIImage(named: "PlayIcon"))
        }
    }
    
    func setSavingStatus(_ status: Bool, by view: DetailsViewProtocol) {
        isSaved = status;
        self.updateSaveRemoveButton(for: isSaved, by: view)
        
    }
    
    func toggleSavingStatus(by view: DetailsViewProtocol) {
        isSaved = !isSaved
        self.updateSaveRemoveButton(for: isSaved, by: view)
    }
    
    func saveItem(_ giphyItem: GiphyData) {
        GifPreview.saveToPersistance(giphyItem)
    }
    
    func checkIfItemIsExists(_ giphyItem: GiphyData) -> Bool {
        return PersistentService.checkIfItemExists(giphyItem)
    }
    
    func getExistingImage(_ giphyItem: GiphyData) -> UIImage {
        return PersistentService.getExistingImage(giphyItem)
    }
    
    func removeItem(_ giphyItem: GiphyData) {
        PersistentService.deleteItem(giphyItem)
    }
    
    //MARK:- Private mathods
    
    private func updateSaveRemoveButton(for status: Bool, by view: DetailsViewProtocol) {
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
