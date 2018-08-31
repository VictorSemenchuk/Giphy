//
//  DateTests.swift
//  GiphyTests
//
//  Created by Viktar Semianchuk on 8/29/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

import XCTest
@testable import Giphy

class DateTests: XCTestCase {
    
    func test_dateWithFormat_success() {
        let inputString = "2017-01-31 22:26:43"
        let format = "yyyy-MM-dd HH:mm:ss"
        
        let result = Date.date(with: format, from: inputString)
        
        XCTAssertEqual(result, getDateMoc(), "String convertion to Date should be success")
    }
    
    func test_dateWithFormat_failure() {
        let inputString = ""
        let format = "yyyy-MM-dd HH:mm:ss"
        
        let result = Date.date(with: format, from: inputString)
        
        XCTAssertEqual(result, nil, "Convert of invalid String to Date should return nil")
    }
    
    func getDateMoc() -> Date {
        var dateComponents = DateComponents()
        dateComponents.year = 2017
        dateComponents.month = 1
        dateComponents.day = 31
        dateComponents.hour = 22
        dateComponents.minute = 26
        dateComponents.second = 43

        let userCalendar = Calendar.current
        let someDateTime = userCalendar.date(from: dateComponents)
        
        return someDateTime!
    }
    
}
