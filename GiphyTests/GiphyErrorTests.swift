//
//  GiphyErrorTests.swift
//  GiphyTests
//
//  Created by Viktar Semianchuk on 8/29/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

import XCTest
@testable import Giphy

class GiphyErrorTests: XCTestCase {
    
    func test_localizedDescriptionForDownloadError_success() {
        let inputErrorCode = GiphyErrorCode.downloadingError
        let inputError = GiphyError(code: inputErrorCode)
        
        let localizedDescription = inputError?.localizedDescription
        
        XCTAssertEqual(localizedDescription, "Downloading error")
    }
    
    func test_localizedDescriptionForParsingError1_success() {
        let inputErrorCode = GiphyErrorCode.parsingErrorUnknownDataSnapshot
        let inputError = GiphyError(code: inputErrorCode)
        
        let localizedDescription = inputError?.localizedDescription
        
        XCTAssertEqual(localizedDescription, "Parsing error. Unknown data snapshot")
    }
    
    func test_localizedDescriptionForParsingError2_success() {
        let inputErrorCode = GiphyErrorCode.parsingErrorInvalidData
        let inputError = GiphyError(code: inputErrorCode)
        
        let localizedDescription = inputError?.localizedDescription
        
        XCTAssertEqual(localizedDescription, "Parsing error. Invalid data")
    }
    
    func test_localizedDescriptionForParsingError3_success() {
        let inputErrorCode = GiphyErrorCode.parsingErrorFailureSetDataToModel
        let inputError = GiphyError(code: inputErrorCode)
        
        let localizedDescription = inputError?.localizedDescription
        
        XCTAssertEqual(localizedDescription, "Parsing error. Can't set data to model")
    }
    
    func test_localizedDescriptionForFetchingError_success() {
        let inputErrorCode = GiphyErrorCode.fetchingError
        let inputError = GiphyError(code: inputErrorCode)
        
        let localizedDescription = inputError?.localizedDescription
        
        XCTAssertEqual(localizedDescription, "Fetching error")
    }
    
    func test_localizedDescriptionForGetAnimatedImageError_success() {
        let inputErrorCode = GiphyErrorCode.dataErrorFailureGetAnimatedImage
        let inputError = GiphyError(code: inputErrorCode)
        
        let localizedDescription = inputError?.localizedDescription
        
        XCTAssertEqual(localizedDescription, "Can't get animated image")
    }
    
    func test_localizedDescriptionForNoInternetError_success() {
        let inputErrorCode = GiphyErrorCode.noInternet
        let inputError = GiphyError(code: inputErrorCode)
        
        let localizedDescription = inputError?.localizedDescription
        
        XCTAssertEqual(localizedDescription, "The Internet is turn off. Turn on cellular or Wi-Fi to access data")
    }
    
    func test_localizedDescriptionForNoResultsError_success() {
        let inputErrorCode = GiphyErrorCode.noResultsError
        let inputError = GiphyError(code: inputErrorCode)
        
        let localizedDescription = inputError?.localizedDescription
        
        XCTAssertEqual(localizedDescription, "No results")
    }
    
    func test_localizedDescriptionForOtherError_success() {
        let inputErrorCode = GiphyErrorCode.otherError
        let inputError = GiphyError(code: inputErrorCode)
        
        let localizedDescription = inputError?.localizedDescription
        
        XCTAssertEqual(localizedDescription, "Unknow Error")
    }

}
