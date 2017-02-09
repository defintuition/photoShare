//
//  Date Extension.swift
//  Hipstagram
//
//  Created by Annie Tung on 2/8/17.
//  Copyright © 2017 Annie Tung. All rights reserved.
//

import Foundation

extension Date {
    static let dateFormatter = DateFormatter()
    
    var dateString: String {
        Date.dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        return Date.dateFormatter.string(from: self)
    }
}
