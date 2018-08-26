//
//  GiphyFileManager.swift
//  Giphy
//
//  Created by Victor Macintosh on 26/08/2018.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

import Foundation

enum FileType: String {
    case gif = "gif"
}

enum DirectoryType {
    case cache
}

class GiphyFileManager {
    
    private let appDirectory = "Giphy"
    private let fileManager: FileManager!
    
    init() {
        self.fileManager = FileManager.default
    }
    
    func dataFromFileWithName(_ fileName: String, withType type: FileType, from directory: DirectoryType) -> Data? {
        let path = "\(fileName).\(type)"
        return dataFromFileWithPath(path: path, from: directory)
    }
    
    func writeFileWithName(_ fileName: String, data: Data, withType type: FileType, to directory: DirectoryType) {
        let path = "\(fileName).\(type)"
        let rootDirectory = rootDirectoryForDirectoryType(directory: directory)
        if let rootDirectory = rootDirectory {
            _ = createAppDirectoryIfNeeded(at: rootDirectory)
            let fullPath = "\(rootDirectory)/\(appDirectory)/\(path)"
            fileManager.createFile(atPath: fullPath, contents: data, attributes: nil)
        }
    }
    
    func createAppDirectoryIfNeeded(at rootDirectory: String) -> Bool {
        let directoryPath = "\(rootDirectory)/\(appDirectory)"
        let url = URL(fileURLWithPath: directoryPath)
        do {
            try fileManager.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
            return true
        } catch {
            print("Error. Can't create directory")
            return false
        }
    }
    
    func removeAppDirectory(from rootDirectory: String) -> Bool {
        let directoryPath = "\(rootDirectory)/\(appDirectory)"
        do {
            try fileManager.removeItem(atPath: directoryPath)
            return true
        } catch {
            print("Error. Can't remove directory")
            return false
        }
    }
    
    private func dataFromFileWithPath(path: String, from directory: DirectoryType) -> Data? {
        let rootDirectory = rootDirectoryForDirectoryType(directory: directory)
        if let rootDirectory = rootDirectory {
            let fullPath = "\(rootDirectory)/\(appDirectory)/\(path)"
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
