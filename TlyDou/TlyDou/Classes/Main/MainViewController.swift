//
//  MainViewController.swift
//  TlyDou
//
//  Created by jack_tang on 17/5/5.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addChilVcWithStoryboardName("Home")
        addChilVcWithStoryboardName("Live")
        addChilVcWithStoryboardName("Follow")
        addChilVcWithStoryboardName("Profile")
    
    }

   

}

extension MainViewController{
    
    fileprivate func addChilVcWithStoryboardName(_ name: String){
            let child = UIStoryboard.init(name: name, bundle: nil).instantiateInitialViewController()
            addChildViewController(child!)
    }

}
