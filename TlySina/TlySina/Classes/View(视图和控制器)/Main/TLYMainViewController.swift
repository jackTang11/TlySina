//
//  TLYMainViewController.swift
//  TlySina
//
//  Created by jack_tang on 17/4/28.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

import UIKit

class TLYMainViewController: UITabBarController {
    
    lazy var composeButton : UIButton = UIButton.cz_imageButton("tabbar_compose_icon_add", backgroundImageName: "tabbar_compose_button")
    
    override func viewDidLoad() {
        super.viewDidLoad()

       setChildController()
        setupComposeButton()
    }
    
    
    

}

extension TLYMainViewController {
    
    //添加中间按钮
    func setupComposeButton(){
        tabBar.addSubview(composeButton)
        
        let count = CGFloat(childViewControllers.count)
        let w = tabBar.bounds.width / count-1
        
        composeButton.frame = tabBar.bounds.insetBy(dx: w*2, dy: 0)
    }
    
    
    //准备自控制器
   func setChildController(){
    
    let array = [
        ["clsName":"TLYHomeViewController", "titleName":"首页", "imageName":"home"],
        ["clsName":"TLYMessageController", "titleName":"消息", "imageName":"message_center"],
        ["clsName":"UIViewController"],
        ["clsName":"TLYDiscoverController", "titleName":"发现", "imageName":"discover"],
        ["clsName":"TLYProfileController", "titleName":"我的", "imageName":"profile"],
    ]

    for dict in array {
        addChildViewController(controller(dict: dict))
    }
}
    
    
    //创建控制器
    private func controller(dict : [String : String]) -> UIViewController{
        guard let clsName = dict["clsName"],
            let titleName = dict["titleName"],
            let imageName = dict["imageName"],
            let cls = NSClassFromString(Bundle.main.nameSpace + "." + clsName) as? UIViewController.Type
        else {
            
            return UIViewController();
            
        }
        
        //创建控制器
        let vc = cls.init()
        vc.title = titleName
        
        //设置图像
        vc.tabBarItem.image = UIImage(named: ("tabbar_" + imageName))
        vc.tabBarItem.selectedImage = UIImage(named: ("tabbar_" + imageName+"_selected"))?.withRenderingMode(.alwaysOriginal);
        
        
        vc.tabBarItem.setTitleTextAttributes(
            [NSForegroundColorAttributeName : UIColor.orange], for: .highlighted)
        
        vc.tabBarItem.setTitleTextAttributes([NSFontAttributeName:UIFont.systemFont(ofSize: 12)], for: .normal)
        
        let nav = TLYNavController(rootViewController: vc)
        return nav;
        
    
    }
    
    
}

