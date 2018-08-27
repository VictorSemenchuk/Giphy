//
//  DetailsViewPresenter.swift
//  Giphy
//
//  Created by Viktar Semianchuk on 8/27/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

import Foundation
import UIKit

@objc protocol DetailsViewPresenterDelegate {
    
}

@objc class DetailsViewPresenter: NSObject {
    
    var view: DetailsViewPresenterDelegate!
    
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
    
}
