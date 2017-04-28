//
//  Bundle+Extension.swift
//  TlySina
//
//  Created by jack_tang on 17/4/28.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

import Foundation
extension Bundle{

    var nameSpace : String{
        return infoDictionary?["CFBundleName"] as? String ?? ""
    }

}

