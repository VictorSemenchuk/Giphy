//
//  Rating.swift
//  Giphy
//
//  Created by Viktar Semianchuk on 8/28/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

import Foundation

@objc enum RatingType: NSInteger {
    case ratedY, ratedG, ratedPG, ratedPG13, ratedR, unrated
    
    static public var allCases: [RatingType] {
        var values: [RatingType] = []
        var index = 0
        while let element = self.init(rawValue: index) {
            values.append(element)
            index += 1
        }
        return values
    }
}

@objc class Rating: NSObject {
    
    @objc static public func stringDescription(typeFor rating: RatingType) -> String {
        switch rating {
        case .ratedY:
            return "y"
        case .ratedG:
            return "g"
        case .ratedPG:
            return "pg"
        case .ratedPG13:
            return "pg-13"
        case .ratedR:
            return "r"
        case .unrated:
            return "unrated"
        }
    }
    
    @objc static public func allRatingTypes() -> [String] {
        var types = [String]()
        for rating in RatingType.allCases {
            types.append(stringDescription(typeFor: rating))
        }
        return types
    }
    
    @objc static public func ratingTypesCount() -> Int {
        return RatingType.allCases.count
    }
    
}


