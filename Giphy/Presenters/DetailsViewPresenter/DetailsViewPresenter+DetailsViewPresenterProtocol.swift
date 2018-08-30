//
//  DetailsViewPresenter+DetailsViewPresenterProtocol.swift
//  Giphy
//
//  Created by Viktar Semianchuk on 8/30/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

import Foundation

extension DetailsViewPresenter: DetailsViewPresenterProtocol {
    
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
        let date = Date.date(with: kInputDateFormat, from: inputDate)
        if let date = date {
            return String.string(with: kOutputDateFormat, from: date)
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
            view.setIconForStartStopPlayingButton(UIImage(named: kStopIconName))
        } else {
            self.animatedImage = imageView.image
            imageView.image = nil;
            imageView.image = self.animatedImage?.images![0];
            view.setIconForStartStopPlayingButton(UIImage(named: kPlayIconName))
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
    
}
