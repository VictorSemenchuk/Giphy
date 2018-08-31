//
//  ParserService.swift
//  Giphy
//
//  Created by Viktar Semianchuk on 8/24/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ParserService {
    
    func parse(snapshot: DataSnapshot, completion: ([GiphyData]?, GiphyError?) -> Swift.Void) {
        guard let snapshotValues = snapshot.values else {
            completion(nil, GiphyError(code: .parsingErrorUnknownDataSnapshot))
            return
        }
        var results = [GiphyData]()
        let parser = JSONParser<GiphyData>()
        for value in snapshotValues {
            if let valueDictionary = value as? [String: Any] {
                do {
                    let data = try JSONSerialization.data(withJSONObject: valueDictionary, options: [])
                    let result = parser.parse(data: data)
                    if let validResult = result {
                        results.append(validResult)
                    } else {
                        completion(nil, GiphyError(code: .parsingErrorFailureSetDataToModel))
                    }
                } catch {
                    completion(nil, GiphyError(code: .parsingErrorInvalidData))
                }
            }
        }
        completion(results, nil)
    }
    
}
