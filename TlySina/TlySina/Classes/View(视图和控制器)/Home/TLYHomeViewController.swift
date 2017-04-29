//
//  TLYHomeViewController.swift
//  TlySina
//
//  Created by jack_tang on 17/4/28.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

import UIKit

private let cell = "cellId"

class TLYHomeViewController: TLYBaseViewController {

    
    lazy var arrayM = [String]()
    
    @objc fileprivate func showFriends(){
    
        print(#function)
        
        let vc = TLYTestController()
        vc.hidesBottomBarWhenPushed = true;
        navigationController?.pushViewController(vc , animated: true);
        
    }
    
}


extension TLYHomeViewController{

   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayM.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let tabcell =  tableView.dequeueReusableCell(withIdentifier: cell, for: indexPath)
        tabcell.textLabel?.text = arrayM[indexPath.item]
        
        return tabcell
        
    }
    

}


extension TLYHomeViewController{
    
    override func setupUI() {
        super.setupUI()
        navItem.leftBarButtonItem = UIBarButtonItem(title: "好友", fontSize: 15, self, action: #selector(showFriends),false)
        tabview?.register(UITableViewCell.self, forCellReuseIdentifier: cell)
        
        for i in 0..<20 {
          arrayM.append("这是第\(i)个数据")
        }
        
    }
    
}
