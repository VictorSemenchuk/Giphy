//
//  UIViewController+Alert.swift
//  Giphy
//
//  Created by Viktar Semianchuk on 8/30/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

import Foundation

extension UIViewController {
    
    func showAlertWithTitle(_ title: String?, message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}
