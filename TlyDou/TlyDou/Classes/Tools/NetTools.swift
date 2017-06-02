//
//  NetTools.swift
//  TlyDou
//
//  Created by jack_tang on 17/5/8.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

import UIKit
import Alamofire


enum HTTPMethondType {

    case GET
    case POST
}

class NetTools{

    class func request(type : HTTPMethondType? = HTTPMethondType.GET,url: String, params : [String : Any]? = nil,finishRequest : @escaping (_ data : Any) -> ()){
        let methodtype = type == .GET ? HTTPMethod.get : HTTPMethod.post
        
        Alamofire.request(url, method: methodtype, parameters: params).responseJSON { (response) in
            
            guard let result = response.result.value else {
                print(response.result.error ?? "网络失败")
                return
            }
        
            finishRequest(result)
        }
    
    }
    
}
