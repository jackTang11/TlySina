//
//  Date.swift
//  TlyDou
//
//  Created by jack_tang on 17/5/8.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

import Foundation

extension NSDate {
   class func getLongTime() -> String {
        let data = Date()
        let interval = Int(data.timeIntervalSince1970)
        return "\(interval)"
    }
}
