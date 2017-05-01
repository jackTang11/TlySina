//
//  TLYNetWorkTool-Extension.swift
//  TlySina
//
//  Created by jack_tang on 17/5/1.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

import Foundation

extension TLYNetWorkTool{

    
    func statusList(completion : @escaping (_ list: [[String: AnyObject]]?,_ isSuccess: Bool) -> ()){
        let url = "https://api.weibo.com/2/statuses/home_timeline.json"
        taokenHttp(urlString: url, paramters: nil) { (json, success) in
            
            let result = json?["status"] as? [[String: AnyObject]]
            
            completion(result!, success)
        }
    }
    
    
    
    

}
