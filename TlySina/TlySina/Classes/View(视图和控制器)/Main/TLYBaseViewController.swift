//
//  TLYBaseViewController.swift
//  TlySina
//
//  Created by jack_tang on 17/4/28.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

import UIKit

class TLYBaseViewController: UIViewController {

    
    var tabview : UITableView?
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
        setNavBar()
        setTableView()
    }
    
    private func setNavBar(){
        view.addSubview(navigation)
        view.backgroundColor = UIColor.cz_random()
        navigation.items = [navItem]
        automaticallyAdjustsScrollViewInsets = false
        navigation.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.darkGray]
    }
    
    
    private func setTableView(){
        tabview = UITableView(frame: view.bounds, style: .plain)
        view.insertSubview(tabview!, belowSubview: navigation);
        tabview?.dataSource = self
        tabview?.delegate = self
        tabview?.contentInset = UIEdgeInsets(top: navigation.bounds.height,
                                             left: 0,
                                             bottom: tabBarController?.tabBar.bounds.height ?? 49,
                                             right: 0)
    }
}


extension TLYBaseViewController : UITableViewDataSource,UITableViewDelegate{

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0;
    }


}

