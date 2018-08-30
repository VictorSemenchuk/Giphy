//
//  SettingsViewPresenter.swift
//  Giphy
//
//  Created by Viktar Semianchuk on 8/28/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

import Foundation

@objc protocol SettingsViewPresenterProtocol: class {
    func updateRatingSetting(newValue: NSInteger) -> Int
    func getRattingSetting() -> Int
    func clearCache()
    
}

@objcMembers class SettingsViewPresenter: NSObject, SettingsViewPresenterProtocol {
    
    func updateRatingSetting(newValue: NSInteger) -> Int {
        let oldValue = getRattingSetting()
        UserDefaults.standard.set(newValue, forKey: kRatingSettingKey)
        return oldValue
    }
    
    func getRattingSetting() -> Int {
        var value = 0
        if let oldValue = UserDefaults.standard.object(forKey: kRatingSettingKey) as? Int {
            value = oldValue
        }
        return value
    }
    
    func clearCache() {
        let fileManager = GiphyFileManager()
        let path = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true) [0]
        _ = fileManager.removeAppDirectory(from: path)
    }
    
}
