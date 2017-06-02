//
//  GameViewModel.swift
//  TlyDou
//
//  Created by jack_tang on 17/5/10.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

import UIKit

class GameViewModel{
    
    lazy var gameModels = [BaseGameModel]()

}

extension GameViewModel {

    func loadGameData(finishCallBack : @escaping () -> ()){
    
        NetTools.request( url: "http://capi.douyucdn.cn/api/v1/getColumnDetail?shortName=game") { (data) in
            
            guard let data = data as? [String : AnyObject] else { return }
            
            guard let dataArray = data["data"] as? [[String : NSObject]] else { return }
            
            
            for dict in dataArray{
                self.gameModels.append(BaseGameModel(dict: dict))
            }
            finishCallBack()
        }
    }
}
