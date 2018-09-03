//
//  GiphyService.swift
//  Giphy
//
//  Created by Viktar Semianchuk on 8/24/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

import Foundation

@objc enum GiphyServiceError: Int {
    case NoError
    case FetchingDataError
}

@objc protocol GiphyServiceProtocol: class {
    @objc func fetchTrends(with offset: Int, limit: Int, completion: @escaping ([GiphyData]?, GiphyError?) -> Void)
    @objc func fetchItemsBySearchRequest(_ searchRequest: String, with offset: Int, limit: Int, completion: @escaping ([GiphyData]?, GiphyError?) -> Void)
}

@objcMembers public class GiphyService: NSObject, GiphyServiceProtocol {
    private var apiKey: String = "dc6zaTOxFJmzC"
    
    @objc func fetchTrends(with offset: Int, limit: Int, completion: @escaping ([GiphyData]?, GiphyError?) -> Void) {
        let url = "https://api.giphy.com/v1/gifs/trending?api_key=\(apiKey)&limit=\(limit)&offset=\(offset)"
        fetchData(from: url) { (data, error) in
            completion(data, error)
        }
    }
    
    @objc func fetchItemsBySearchRequest(_ searchRequest: String, with offset: Int, limit: Int, completion: @escaping ([GiphyData]?, GiphyError?) -> Void) {
        let ratingCode = UserDefaults.standard.integer(forKey: kRatingSettingKey)
        if let ratingType = RatingType(rawValue: ratingCode) {
            let rating = Rating.stringDescription(typeFor: ratingType)
            let url = "https://api.giphy.com/v1/gifs/search?api_key=\(apiKey)&q=\(searchRequest)&limit=\(limit)&offset=\(offset)&rating=\(rating)"
            fetchData(from: url) { (data, error) in
                completion(data, error)
            }
        } else {
            completion(nil, GiphyError(code: .fetchingError))
        }
    }
    
    private func fetchData(from url: String, completion: @escaping ([GiphyData]?, GiphyError?) -> Void) {
        let donwloadManager = DownloadManager()
        donwloadManager.fetchData(fromURL: url) { (data, error) in
            guard let data = data, error == nil else {
                if error != nil {
                    completion(nil, error! as GiphyError)
                } else {
                    completion(nil, GiphyError(code: .fetchingError))
                }
                return
            }
            let snapshot = DataSnapshot()
            snapshot.values = snapshot.setValuesBy(data: data)
            let parserService = ParserService()
            parserService.parse(snapshot: snapshot, completion: { (results, error) in
                if error != nil {
                    completion(nil, error)
                } else {
                    completion(results, nil)
                }
            })
        }
    }
}
