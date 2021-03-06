//
//  DataSnapshot.swift
//  Giphy
//
//  Created by Viktar Semianchuk on 8/24/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

import Foundation

@objc public class DataSnapshot: NSObject {
    var values: [Any]?
    
    func setValuesBy(data: Data) -> [Any]? {
        let json = try? JSONSerialization.jsonObject(with: data, options: [])
        guard let jsonDictionary = json as? [String: Any] else {
            return nil
        }
        return jsonDictionary["data"] as? [Any]
    }
}
