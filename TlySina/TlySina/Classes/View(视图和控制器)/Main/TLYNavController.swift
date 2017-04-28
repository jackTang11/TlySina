//
//  TLYNavController.swift
//  TlySina
//
//  Created by jack_tang on 17/4/28.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

import UIKit

class TLYNavController: UINavigationController {
    
      override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.isHidden = true

    }
    
  
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if(childViewControllers.count  > 0){
            viewController.hidesBottomBarWhenPushed = true
            
            if let vc = viewController as? TLYBaseViewController{
                var title = "返回"
                
                if childViewControllers.count == 1 {
                    title = childViewControllers.first?.title ?? "返回"
                }
                vc.navItem.leftBarButtonItem = UIBarButtonItem(title: title, self, action: #selector(back),true)
            }
            
            
        } 
        super.pushViewController(viewController, animated: true)
    }
    
}

extension TLYNavController{

    func back(){
        popViewController(animated: true)
    }

}
