//
//  Date+Format.swift
//  Giphy
//
//  Created by Viktar Semianchuk on 8/27/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

import Foundation

extension Date {
    
    static func date(with format: String, from string: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format;
        return dateFormatter.date(from: string) ?? Date()
    }
    
}
