//
//  String+Format.swift
//  Giphy
//
//  Created by Viktar Semianchuk on 8/27/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

import Foundation

extension String {
    
    static func string(with format: String, from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format;
        return dateFormatter .string(from: date);
    }
    
}
