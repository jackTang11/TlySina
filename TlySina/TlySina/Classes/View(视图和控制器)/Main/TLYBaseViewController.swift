//
//  TLYBaseViewController.swift
//  TlySina
//
//  Created by jack_tang on 17/4/28.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

import UIKit

class TLYBaseViewController: UIViewController {

    var isUserLogin: Bool = false
    var tabview : UITableView?
    var refresh : UIRefreshControl?
    var visinfos : [String: String]?
    lazy var navigation = UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.cz_screenWidth(), height: 64))
    lazy var navItem = UINavigationItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }
    
    
    /// 重新title set方法
    override var title: String?{
        didSet{
            navItem.title = title
        }
    }
    
    
    func loadData(){
        refresh?.endRefreshing()
    }
  
}

extension TLYBaseViewController{
    
   fileprivate func setupUI(){
        setNavBar()
        isUserLogin ? setTableView() : setVisiHomeView()
    }
    
    private func setNavBar(){
        view.addSubview(navigation)
        view.backgroundColor = UIColor.cz_random()
        navigation.items = [navItem]
        automaticallyAdjustsScrollViewInsets = false
        //设置navaBar整个背景颜色
        navigation.barTintColor = UIColor.cz_color(withHex: 0xf6f6f6)
        //设置navBar的字体颜色
        navigation.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.darkGray]
        //设置系统按钮的文字渲染的颜色
        navigation.tintColor = UIColor.orange
    }
    
    
   func setTableView(){
        tabview = UITableView(frame: view.bounds, style: .plain)
        view.insertSubview(tabview!, belowSubview: navigation);
        tabview?.dataSource = self
        tabview?.delegate = self
        tabview?.contentInset = UIEdgeInsets(top: navigation.bounds.height,
                                             left: 0,
                                             bottom: tabBarController?.tabBar.bounds.height ?? 49,
                                             right: 0)
        
        refresh = UIRefreshControl();
        tabview?.addSubview(refresh!)
        refresh?.addTarget(self, action:#selector(loadData), for: .valueChanged)
        
    }
    
    
    private func setVisiHomeView(){
        let visiHomeView : VisitView = VisitView(frame: view.bounds)
        self.view.insertSubview(visiHomeView, belowSubview: navigation)
        visiHomeView.visiInfos = visinfos
        
        visiHomeView.loginBtn.addTarget(self, action: #selector(login), for: .touchUpInside)
         visiHomeView.registBtn.addTarget(self, action: #selector(regist), for: .touchUpInside)
        
         navItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: .plain, target: self, action:  #selector(regist))
          navItem.rightBarButtonItem = UIBarButtonItem(title: "登陆", style: .plain, target: self, action:  #selector(login))
        
        
    }
}


extension TLYBaseViewController{

    func login(){
    
    
    }
    
    
    func regist(){
    
    
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

