//
//  SettingsViewPresenter.swift
//  Giphy
//
//  Created by Viktar Semianchuk on 8/28/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

import Foundation

@objc protocol SettingsViewPresenterDelegate {
    
}

@objcMembers class SettingsViewPresenter: NSObject {
    
    var view: SettingsViewPresenterDelegate!
    
    init(view: SettingsViewPresenterDelegate) {
        self.view = view
    }
    
    func updateRatingSetting(newValue: NSInteger) -> Int {
        let oldValue = getRattingSetting()
        UserDefaults.standard.set(newValue, forKey: "ratingSetting")
        return oldValue
    }
    
    @objc public func getRattingSetting() -> Int {
        var value = 0
        if let oldValue = UserDefaults.standard.object(forKey: "ratingSetting") as? Int {
            value = oldValue
        }
        return value
    }
    
    @objc public func clearCache() {
        let fileManager = GiphyFileManager()
        let path = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true) [0]
        _ = fileManager.removeAppDirectory(from: path)
    }
    
}
