//
//  ParserService.swift
//  Giphy
//
//  Created by Viktar Semianchuk on 8/24/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

import Foundation

class ParserService {
    func parse(snapshot: DataSnapshot, completion: ([GiphyData]?) -> Swift.Void) {
        guard let snapshotValues = snapshot.values else {
            completion(nil)
            return
        }
        var results = [GiphyData]()
        let parser = JSONParser<GiphyData>()
        for value in snapshotValues {
            if let valueDictionary = value as? [String: Any], let data = try? JSONSerialization.data(withJSONObject: valueDictionary, options: []) {
                let result = parser.parse(data: data)
                if let validResult = result {
                    results.append(validResult)
                }
            }
        }
        completion(results)
    }
}
