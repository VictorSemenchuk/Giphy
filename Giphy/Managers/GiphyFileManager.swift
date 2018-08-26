//
//  GiphyFileManager.swift
//  Giphy
//
//  Created by Victor Macintosh on 26/08/2018.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

import Foundation

enum FileType: String {
    case gif = ".gif"
}

enum DirectoryType {
    case cache
}

class GiphyFileManager {
    
    func dataFromFileWithName(_ fileName: String, withType type: FileType, from directory: DirectoryType) -> Data? {
        let path = "/\(fileName).\(type)"
        return dataFromFileWithPath(path: path, from: directory)
    }
    
    func writeFileWithName(_ fileName: String, data: Data, withType type: FileType, to directory: DirectoryType) {
        let fileManager = FileManager.default
        let path = "/\(fileName).\(type)"
        let rootDirectory = rootDirectoryForDirectoryType(directory: directory)
        if let rootDirectory = rootDirectory {
            let fullPath = "\(rootDirectory)\(path)"
            fileManager.createFile(atPath: fullPath, contents: data, attributes: nil)
        }
    }
    
    private func dataFromFileWithPath(path: String, from directory: DirectoryType) -> Data? {
        let rootDirectory = rootDirectoryForDirectoryType(directory: directory)
        if let rootDirectory = rootDirectory {
            let fullPath = "\(rootDirectory)\(path)"
            print(fullPath)
            let url = URL(fileURLWithPath: fullPath)
            return try? Data(contentsOf: url)
        } else {
            return nil
        }
    }
    
    private func rootDirectoryForDirectoryType(directory: DirectoryType) -> String? {
        switch directory {
        case .cache:
            return NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0]
        }
    }
    
}
