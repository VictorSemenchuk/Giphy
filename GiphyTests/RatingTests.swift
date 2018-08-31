//
//  RatingTests.swift
//  GiphyTests
//
//  Created by Victor Macintosh on 30/08/2018.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

import XCTest
@testable import Giphy

class RatingTests: XCTestCase {
    
    func test_allCases_success() {
        let expectedValues = [RatingType.ratedY, RatingType.ratedG,RatingType.ratedPG, RatingType.ratedPG13, RatingType.ratedR, RatingType.unrated]
        
        let values = RatingType.allCases
        
        XCTAssertEqual(expectedValues, values, "Values should be equal")
    }
    
    func test_stringDescriptionRatedY_success() {
        let description = Rating.stringDescription(typeFor: .ratedY)
        XCTAssertEqual("y", description)
    }
    
    func test_stringDescriptionRatedG_success() {
        let description = Rating.stringDescription(typeFor: .ratedG)
        XCTAssertEqual("g", description)
    }
    
    func test_stringDescriptionRatedPG_success() {
        let description = Rating.stringDescription(typeFor: .ratedPG)
        XCTAssertEqual("pg", description)
    }
    
    func test_stringDescriptionRatedPG13_success() {
        let description = Rating.stringDescription(typeFor: .ratedPG13)
        XCTAssertEqual("pg-13", description)
    }
    
    func test_stringDescriptionRatedR_success() {
        let description = Rating.stringDescription(typeFor: .ratedR)
        XCTAssertEqual("r", description)
    }
    
    func test_stringDescriptionRatedUnrated_success() {
        let description = Rating.stringDescription(typeFor: .unrated)
        XCTAssertEqual("unrated", description)
    }
    
    func test_allRatingTypes_success() {
        let expectedValues = ["y", "g", "pg", "pg-13", "r", "unrated"]
        let values = Rating.allRatingTypes()
        XCTAssertEqual(expectedValues, values)
    }
    
    func test_ratingTypesCount_success() {
        XCTAssertEqual(6, Rating.ratingTypesCount())
    }
    
    
    
}
