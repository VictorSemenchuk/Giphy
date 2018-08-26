//
//  FileManagerTests.swift
//  GiphyTests
//
//  Created by Victor Macintosh on 26/08/2018.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

import XCTest
@testable import Giphy

class FileManagerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_createAppDirectoryIfNeeded_success() {
        let fileManager = GiphyFileManager()
        let path = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0]
        let result = fileManager.createAppDirectoryIfNeeded(at: path)
        XCTAssert(result, "Can't create directory")
    }
    
    func test_removeAppDirectory_success() {
        let fileManager = GiphyFileManager()
        let path = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0]
        _ = fileManager.createAppDirectoryIfNeeded(at: path)
        let result = fileManager.removeAppDirectory(from: path)
        XCTAssert(result, "Can't remove directory")
    }
    
}
