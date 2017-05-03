//
//  WBStatus.swift
//  TlySina
//
//  Created by jack_tang on 17/5/1.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

import UIKit
import YYModel
class WBStatus: NSObject {

    var id: Int64 = 0
    var text: String?
    
    
    override var description: String{
        return yy_modelDescription()
    }
}
