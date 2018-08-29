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

@objc class DetailsViewPresenter: NSObject {
    
    weak var view: DetailsViewPresenterDelegate!
    var animatedImage: UIImage?
    @objc public var isSaved: Bool
    
    @objc init(view: DetailsViewPresenterDelegate) {
        self.view = view
        self.isSaved = false
    }
    
    @objc public func fetchOriginalImageForGiphyItem(_ giphyItem: GiphyData, completion: @escaping (UIImage?) -> Void) {
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
    
    @objc public func convertDate(inputDate: String) -> String {
        let date = Date.date(with: "yyyy-MM-dd HH:mm:ss", from: inputDate)
        if let date = date {
            return String.string(with: "dd MMM yyyy", from: date)
        } else {
            return ""
        }
    }
    
    @objc public func shareGiphyItem(_ giphyItem: GiphyData, image: UIImage) {
        let vc = self.view as! UIViewController
        let activityViewController = UIActivityViewController(activityItems: [giphyItem.title!, giphyItem.image?.original?.url ?? "", image], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = vc.view
        vc.present(activityViewController, animated: true, completion: nil)
    }
    
    @objc public func stopPlay(imageView: UIImageView) {
        if (self.animatedImage != nil) {
            imageView.image = self.animatedImage;
            self.animatedImage = nil
            self.view.setStopIconForStopPlayButton()
        } else {
            self.animatedImage = imageView.image
            imageView.image = nil;
            imageView.image = self.animatedImage?.images![0];
            self.view.setPlayIconForStopPlayButton()
        }
    }
    
    @objc public func setSavingStatus(_ status: Bool) {
        isSaved = status;
        self.view.setSaveRemoveButtonFor(savingStatus: isSaved)
    }
    
    @objc public func toggleSavingStatus() {
        isSaved = !isSaved
        self.view.setSaveRemoveButtonFor(savingStatus: isSaved)
    }
    
    @objc public func saveGiphyItem(_ giphyItem: GiphyData) {
        GifPreview.saveToPersistance(giphyItem)
    }
    
    @objc public func checkIfItemExists(_ giphyItem: GiphyData) -> Bool {
        return PersistentService.checkIfItemExists(giphyItem)
    }
    
    @objc public func getExistingImage(_ giphyItem: GiphyData) -> UIImage {
        return PersistentService.getExistingImage(giphyItem)
    }
    
    @objc public func removeItem(_ giphyItem: GiphyData) {
        PersistentService.deleteItem(giphyItem)
    }

}
