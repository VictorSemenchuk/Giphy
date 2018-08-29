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
    
    func test_writeFileWithName_success() {
        let fileManager  = GiphyFileManager()
        let inputData = Data()
        let inputFileName = "testFilename"
        let inputDirectory = DirectoryType.cache
        let inputFileType = FileType.gif
        
        fileManager.writeFileWithName(inputFileName, data: inputData, withType: inputFileType, to: inputDirectory)
        let writtenData = fileManager.dataFromFileWithName(inputFileName, withType: inputFileType, from: inputDirectory)
        
        XCTAssertNotEqual(writtenData, nil, "Data from valid file can't be nil")
    }
    
    func test_dataFromFileWithName_success() {
        let fileManager  = GiphyFileManager()
        let inputFileName = "testFilename"
        let inputDirectory = DirectoryType.cache
        let inputFileType = FileType.gif
        
        let writtenData = fileManager.dataFromFileWithName(inputFileName, withType: inputFileType, from: inputDirectory)
        
        XCTAssertNotEqual(writtenData, nil, "Data from invalid file should be nil")
    }
    
    func test_dataFromFileWithName_failure() {
        let fileManager  = GiphyFileManager()
        let inputFileName = "testFilename1"
        let inputDirectory = DirectoryType.cache
        let inputFileType = FileType.gif
        
        let writtenData = fileManager.dataFromFileWithName(inputFileName, withType: inputFileType, from: inputDirectory)
        
        XCTAssertEqual(writtenData, nil, "Data from invalid file should be nil")
    }
    
}
