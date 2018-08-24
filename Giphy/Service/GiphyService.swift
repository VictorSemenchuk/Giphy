//
//  GiphyService.swift
//  Giphy
//
//  Created by Viktar Semianchuk on 8/24/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

import Foundation

enum GiphyServiceError: Error {
    case FetchingDataError
}

@objc public class GiphyService: NSObject {
    private var apiKey: String = "znWbf6XFLaogUUU7wI6fPEOPxkGIO7cH"
    private var limit: Int = 25
    
//    init(limit: Int = 25, apiKey: String = "znWbf6XFLaogUUU7wI6fPEOPxkGIO7cH") {
//        self.apiKey = apiKey
//        self.limit = limit
//    }
    
    @objc public func test() {
        
    }
    
    func fetchTrends(with offset: Int, completion: @escaping ([GiphyData]?, GiphyServiceError?) -> Swift.Void) {
        let url = "https://api.giphy.com/v1/gifs/trending?api_key=\(apiKey)&limit=\(limit)&offset=\(offset)"
        fetchData(from: url) { (data, error) in
            completion(data, error)
        }
    }
    
    func fetchItemsBySearchRequest(_ searchRequest: String, with offset: Int, completion: @escaping ([GiphyData]?, GiphyServiceError?) -> Swift.Void) {
        let url = "https://api.giphy.com/v1/gifs/search?api_key=\(apiKey)&q=\(searchRequest)&limit=\(limit)&offset=\(offset)"
        fetchData(from: url) { (data, error) in
            completion(data, error)
        }
    }
    
    private func fetchData(from url: String, completion: @escaping ([GiphyData]?, GiphyServiceError?) -> Swift.Void) {
        let donwloadManager = DownloadManager()
        donwloadManager.fetchData(fromURL: url) { (data) in
            guard let data = data else {
                completion(nil, GiphyServiceError.FetchingDataError)
                return
            }
            let snapshot = DataSnapshot()
            snapshot.values = snapshot.setValuesBy(data: data)
            let parserService = ParserService()
            parserService.parse(snapshot: snapshot, completion: { (results) in
                completion(results, nil)
            })
        }
    }
}
