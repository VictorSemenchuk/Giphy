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
import CoreData

@objc protocol DetailsViewPresenterDelegate: class {
    @objc func setPlayIconForStopPlayButton();
    @objc func setStopIconForStopPlayButton();
}

@objc class DetailsViewPresenter: NSObject {
    
    weak var view: DetailsViewPresenterDelegate!
    var animatedImage: UIImage?
    
    @objc init(view: DetailsViewPresenterDelegate) {
        self.view = view
    }

    
    @objc public func fetchOriginalImageForGiphyItem(_ giphyItem: GiphyData, completion: @escaping (UIImage?) -> Void) {
        let dataService = DataService()
        dataService.getAnimatedOriginalImageFor(giphyData: giphyItem) { (image) in
            DispatchQueue.main.async {
                completion(image)
            }
        }
    }
    
    
    
    @objc public func convertDate(inputDate: String) -> String {
        let date = Date.date(with: "yyyy-MM-dd HH:mm:ss", from: inputDate)
        return String.string(with: "dd MMM yyyy", from: date)
    }
    
    @objc public func shareGiphyItem(_ giphyItem: GiphyData, image: UIImage) {
        let vc = self.view as! UIViewController
        let activityViewController = UIActivityViewController(activityItems: [giphyItem.title!, giphyItem.image?.original?.url, image], applicationActivities: nil)
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
    
    @objc public func saveGiphiItem(_ giphyItem: GiphyData){
        
        GifPreview.saveToPersistance(giphyItem)
    }
    
    @objc public func checkIfItemExists(_ giphyItem: GiphyData) -> Bool{

        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let backgroundContext = appDelegate?.persistentContainer.newBackgroundContext()
        
            let request: NSFetchRequest<NSFetchRequestResult> = GifPreview.fetchRequest()
            request.predicate = NSPredicate(format: "dataId = %@", giphyItem.dataId!)
            
           var result: Bool = false
            
            do {
                result = (try backgroundContext?.count(for: request))! > 0
            } catch {
                NSLog("My Error: %@", error as NSError)
            }
            
            return result
        }
    
    @objc public func getExistingImage(_ giphyItem: GiphyData) -> UIImage{
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let backgroundContext = appDelegate?.persistentContainer.newBackgroundContext()
        
        let request: NSFetchRequest<GifPreview> = GifPreview.fetchRequest()
        request.predicate = NSPredicate(format: "dataId = %@", giphyItem.dataId!)
        
        var result:[GifPreview] = []
        
            do {
                result = (try backgroundContext?.fetch(request))!
             } catch {
                    NSLog("My Error: %@", error as NSError)
            }
        
        return UIImage.animatedImage(data: (result.first?.fullGif?.image)!)!
        
    }

}
