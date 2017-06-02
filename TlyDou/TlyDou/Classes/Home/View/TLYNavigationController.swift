//
//  TLYNavigationController.swift
//  TlyDou
//
//  Created by jack_tang on 17/5/11.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

import UIKit

class TLYNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

       
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        viewController.hidesBottomBarWhenPushed = true
        super.pushViewController(viewController, animated: animated)
    }

}
