//
//  RecommendViewModel.swift
//  TlyDou
//
//  Created by jack_tang on 17/5/8.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

import UIKit

class RecommendViewModel: NSObject {
    // MARK:- 懒加载属性
    lazy var cycleModels : [CycleModel] = [CycleModel]()
    lazy var anchorGroups = [AnchorGroup]()
     lazy var hotAnchorGroup = AnchorGroup()
     lazy var prettyAnchorGroup = AnchorGroup()

}


extension RecommendViewModel {
    
    func requestRecommenData(finishData : @escaping () -> () ) {
        
        
        let url : String = "http://capi.douyucdn.cn/api/v1/getbigDataRoom"
        let paramas = ["time": NSDate.getLongTime()]
        
      let queue =  DispatchGroup()
        
      queue.enter()
        NetTools.request(url: url, params: paramas) { (result) in
            guard let dictArray = self.parseData(result: result) else{
                print("解析失败")
                return
            }
             var tempArray = [AnchorModel]()
            for item in dictArray {
                tempArray.append( AnchorModel(dict: item))
            }
            self.hotAnchorGroup.anchors = tempArray
            // 3.遍历字典,并且转成模型对象
            // 3.1.设置组的属性
            self.hotAnchorGroup.tag_name = "热门"
            self.hotAnchorGroup.icon_name = "home_header_hot"
            queue.leave()
            
        }
       
        
        queue.enter()
        NetTools.request(url: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", params: ["limit":"4", "offset" : "0", "time" : NSDate.getLongTime()]) { (result) in
            // 1.获取解析的字典数据
            guard let dictArray = self.parseData(result: result) else { return }
            // 3.遍历字典,并且转成模型对象
            // 3.1.设置组的属性
            self.prettyAnchorGroup.tag_name = "颜值"
            self.prettyAnchorGroup.icon_name = "home_header_phone"
            
            // 3.2.获取主播数据
            for dict in dictArray {
                let anchor = AnchorModel(dict: dict)
                self.prettyAnchorGroup.anchors.append(anchor)
            }
           
            queue.leave()
           
        }
        
        queue.enter()
        //游戏数据
        NetTools.request(url: "http://capi.douyucdn.cn/api/v1/getHotCate", params: ["limit":"4", "offset" : "0", "time" : NSDate.getLongTime()]) { (result) in
            // 1.获取解析的字典数据
            guard let dictArray = self.parseData(result: result) else { return }
            
            
            // 3.2.获取主播数据
            for dict in dictArray {
                self.anchorGroups.append(AnchorGroup(dict: dict))
                
            }
            queue.leave()
        }
        
        
        
        queue.notify(queue: DispatchQueue.main) {
            self.anchorGroups.insert(self.prettyAnchorGroup, at: 0)
            self.anchorGroups.insert(self.hotAnchorGroup, at: 0)
            finishData()
        }
    }
    
    func parseData(result : Any) -> [[String : NSObject]]? {
        guard let result = result as? [String : NSObject] else {
            print("解析失败")
            return nil
        }
        guard let array = result["data"] as? [[String : NSObject]] else {
            print("解析失败")
            return nil
        }
        
        return array
    
    }
    
    
    func requestCycleData(finished : @escaping () -> ()){
        NetTools.request( url:  "http://www.douyutv.com/api/v1/slide/6", params: ["version" : "2.300"]) { (data) in
            guard let result = data as? [String : NSObject] else {return}
            guard let dictArray = result["data"] as? [[String:NSObject]] else {return}
            
            for dict in dictArray{
                self.cycleModels.append(CycleModel(dict: dict))
            }
            finished()
        }
    
    }


}
