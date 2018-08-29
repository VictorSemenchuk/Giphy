//
//  StringTests.swift
//  GiphyTests
//
//  Created by Viktar Semianchuk on 8/29/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

import XCTest
@testable import Giphy

class StringTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_stringToDate_success() {
        let inputDate = getDateMoc()
        let inputFormat = "yyyy-MM-dd HH:mm:ss"
        
        let result = String.string(with: inputFormat, from: inputDate)
        
        XCTAssertEqual(result, "2017-01-31 22:26:43", "Convertable date must be equal output string")
    }
    
    func test_stringToDate_failure() {
        let inputDate = getDateMoc()
        let inputFormat = "yyyy-MM-dd hh:mm:ss"
        
        let result = String.string(with: inputFormat, from: inputDate)
        
        XCTAssertNotEqual(result, "2017-01-31 22:26:43", "Convertable date can't be equal output string with wrong format")
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
