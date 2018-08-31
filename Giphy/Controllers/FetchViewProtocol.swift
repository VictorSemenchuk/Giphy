//
//  FetchViewProtocol.swift
//  Giphy
//
//  Created by Viktar Semianchuk on 8/31/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

import Foundation

@objc protocol FetchViewProtocol {
    @objc func startActivityIndicator()
    @objc func stopActivityIndicator()
    @objc func showMessageLabelWithText(_ text: String)
}
