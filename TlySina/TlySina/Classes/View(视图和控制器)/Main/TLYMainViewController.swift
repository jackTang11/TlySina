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
        setupNewFeatuerView()
    }
    
    
   
    
  @objc fileprivate func middleClick(){
            print("....")
    }

}


extension TLYMainViewController{
    
    var isNewVersion : Bool {
        
        //获取当前版本号
        let currentVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
        
        ///取出保存在用户偏好中的版本号
        let path : String = ("version" as NSString).cz_appendDocumentDir()
        let sandboxVersion = try? String(contentsOfFile: path, encoding: .utf8)
 
        
       _ = try? currentVersion.write(toFile: path, atomically: true, encoding: .utf8)
        
        
        print(currentVersion)
        
        return currentVersion == sandboxVersion
    }
    
    func setupNewFeatuerView(){
    
        let v = isNewVersion ?  WBNewFeatureView.newFeature() : WBWelcomView.welcomView()
        view.addSubview(v)
        
    
    }
    
    


}


extension TLYMainViewController {
    
    //添加中间按钮
  fileprivate  func setupComposeButton(){
        tabBar.addSubview(composeButton)
        
        let count = CGFloat(childViewControllers.count)
        let w = tabBar.bounds.width / count-1
        composeButton.frame = tabBar.bounds.insetBy(dx: w*2, dy: 0)
    
        composeButton.addTarget(self, action: #selector(middleClick), for: .touchUpInside)
    }
    
    
    //准备自控制器
  fileprivate func setChildController(){
    
    let doucdir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    let jsonPath = (doucdir as NSString).appendingPathComponent("main.json")
    var data = NSData(contentsOfFile: jsonPath)
    
    if data == nil {
        let path = Bundle.main.path(forResource: "main.json", ofType: nil)
        data = NSData(contentsOfFile: path!)
    
    }

      guard  let array =  try? JSONSerialization.jsonObject(with: data! as Data, options: []) as? [[String:AnyObject]]
    else {
        return
    }
    
    
    var arrayM : [UIViewController] = [UIViewController]()
    
    for dict in array! {
        arrayM.append(controller(dict: dict))
    }
    
    viewControllers = arrayM
    
}
    
    
    //创建控制器
    private func controller(dict : [String : Any]) -> UIViewController{
        guard let clsName = dict["clsName"] as? String,
            let titleName = dict["titleName"] as? String,
            let imageName = dict["imageName"] as? String,
            let visiDict = dict["visiInfos"] as? [String : String],
            let cls = NSClassFromString(Bundle.main.nameSpace + "." + clsName) as? TLYBaseViewController.Type
            else {
            return UIViewController();
            
            }
        
        //创建控制器
        let vc = cls.init()
        vc.title = titleName
        
        vc.visinfos = visiDict
        
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

