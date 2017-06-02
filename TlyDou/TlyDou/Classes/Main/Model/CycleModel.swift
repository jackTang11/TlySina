//
//  CycleModel.swift
//  TlyDou
//
//  Created by jack_tang on 17/5/9.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

import UIKit

class CycleModel: NSObject {
    /// 轮播标题
    var title : String = ""
    /// 轮播图片
    var pic_url : String = ""
    /// 轮播对应主播信息
    var anchor : AnchorModel?
    /// 主播信息
    var room : [String : NSObject]? {
        didSet {
            guard let room = room else { return }
            anchor = AnchorModel(dict: room)
        }
    }
    // MARK: 构造函数
    init(dict : [String : NSObject]) {
        super.init()
            setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
 
}
