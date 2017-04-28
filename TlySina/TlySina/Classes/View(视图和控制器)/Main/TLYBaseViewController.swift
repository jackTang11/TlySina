//
//  TLYBaseViewController.swift
//  TlySina
//
//  Created by jack_tang on 17/4/28.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

import UIKit

class TLYBaseViewController: UIViewController {

    lazy var navigation = UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.cz_screenWidth(), height: 64))
    lazy var navItem = UINavigationItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    /// 重新title set方法
    override var title: String?{
        didSet{
            navItem.title = title
        }
    }
  
}

extension TLYBaseViewController{
    
    func setupUI(){
        view.addSubview(navigation)
        view.backgroundColor = UIColor.cz_random()
        navigation.items = [navItem]
    }
}
