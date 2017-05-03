//
//  AppDelegate.swift
//  TlySina
//
//  Created by jack_tang on 17/4/28.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge,.carPlay]) { (success, error) in
                print("授权" + (success ? "成功" : "失败"))
            }
        } else { //ios 8.0
            let notificationSetting = UIUserNotificationSettings(types: [.alert,.badge,.sound], categories: nil)
            application.registerUserNotificationSettings(notificationSetting)

        }
        
        window = UIWindow();
        window?.rootViewController = TLYMainViewController();
        window?.makeKeyAndVisible();
        loadAppInfo()
        
        
    
        return true
    }

}

extension AppDelegate{
    
    func loadAppInfo(){
        
        DispatchQueue.global().async { 
            let url =  Bundle.main.url(forResource: "main.json", withExtension: nil)
            let data = NSData(contentsOf: url!)
            let doucdir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
            let jsonPath = (doucdir as NSString).appendingPathComponent("main.json")
            data?.write(toFile: jsonPath, atomically: true)
            print(jsonPath)
        }
    }

}

