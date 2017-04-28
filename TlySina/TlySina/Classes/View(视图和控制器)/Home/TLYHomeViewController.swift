//
//  TLYHomeViewController.swift
//  TlySina
//
//  Created by jack_tang on 17/4/28.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

import UIKit

class TLYHomeViewController: TLYBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
       }
    
    
    @objc fileprivate func showFriends(){
    
        print(#function)
        
        let vc = TLYTestController()
        vc.hidesBottomBarWhenPushed = true;
        navigationController?.pushViewController(vc , animated: true);
        
    }
    
}

extension TLYHomeViewController{
    
    override func setupUI() {
        super.setupUI()
       navItem.leftBarButtonItem = UIBarButtonItem(title: "好友", fontSize: 15, self, action: #selector(showFriends),false)
    }
    
}
