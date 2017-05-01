//
//  TLYNetWorkTool.swift
//  TlySina
//
//  Created by jack_tang on 17/4/30.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

import UIKit
import AFNetworking


enum HTTPMethed {
    case GET
    case POST
}

class TLYNetWorkTool: AFHTTPSessionManager {

    static let share = TLYNetWorkTool()
    
    var access_token : String? = "bgkbl"
    
    
    func taokenHttp(urlString: String,
                    methodType: HTTPMethed = .GET,
                    paramters: [String: AnyObject]?
        ,complation: @escaping (_ json: AnyObject?, _ issuccess: Bool) -> ()){
    
        
        //如果没有token 就返回
        guard let token = access_token else {
            complation("需要token" as AnyObject, false)
            return
        }
        
        var paramters = paramters
        if paramters==nil{
            paramters = [String: AnyObject]()
        }
        
        paramters!["access_token"] = token as AnyObject?
    
        requestHttp(urlString: urlString, paramters: paramters!, complation: complation)
    
    }
    
    
    func requestHttp(urlString: String,
                     methodType: HTTPMethed = .GET,
                     paramters: [String: AnyObject]
                    ,complation: @escaping (_ json: AnyObject?, _ issuccess: Bool) -> ()){
        
        let success = {(data: URLSessionDataTask, json: Any?) -> () in
            complation(json as AnyObject?, true)
        
        }
        
        let failure = {(data: URLSessionDataTask?, error: Any?) -> () in
             complation(nil, false)
        }
        
        if(methodType == .GET){
           
            get(urlString, parameters: paramters, progress: nil, success: success, failure: failure)
            
            
            
        }else{
            post(urlString, parameters: paramters, progress: nil, success: failure, failure: failure)
        
        }
        
       
       
    
    }
    
}
