//
//  AmuseViewModel.swift
//  TlyDou
//
//  Created by jack_tang on 17/5/10.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

import UIKit

class AmuseViewModel{
    var datas = [AnchorGroup]()
}

extension AmuseViewModel {

    func loadAmuseData(finishCallBack : @escaping () -> () ){
    
        NetTools.request( url: "http://capi.douyucdn.cn/api/v1/getHotRoom/2") { (result) in
            guard let result =  result as? [String : AnyObject] else { return }
            
            guard let dictArray = result["data"] as? [[String: NSObject]] else { return }
            
            for dict in dictArray {
                self.datas.append(AnchorGroup(dict: dict))
            }
            
            finishCallBack()
        }
    }
}
