//
//  VisitView.swift
//  TlySina
//
//  Created by jack_tang on 17/4/29.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

import UIKit

/// 访客视图
class VisitView: UIView {

    //图像视图
    fileprivate lazy var hoseIconView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_house"))
    
    //遮罩
    fileprivate lazy var maskIconView = UIImageView(image: UIImage(named: "visitordiscover_feed_mask_smallicon"))
    
    
    //小房子
    fileprivate lazy var iconView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_smallicon"))
    //提示标签
    fileprivate lazy var tipLable : UILabel = UILabel.cz_label(withText: "acbjkasbckasbcksabkcuaacbjkasbckasbcksabkcuaacbjkasbckasbcksabkcuaacbjkasbckasbcksabkcua", fontSize: 14, color: UIColor.darkGray)
    
    //注册按钮
   lazy var registBtn : UIButton =
    UIButton.cz_textButton("注册", fontSize: 16, normalColor: UIColor.orange, highlightedColor: UIColor.black, backgroundImageName: "common_button_white_disable")
    
    //登录按钮
    lazy var loginBtn : UIButton =
        UIButton.cz_textButton("登陆", fontSize: 16, normalColor: UIColor.orange, highlightedColor: UIColor.black, backgroundImageName: "common_button_white_disable")
    
    //访客字典
    var visiInfos : [String:String]?{
        didSet{
        
            guard let imageName = visiInfos?["imageName"],
                let message = visiInfos?["message"] else {
                    return
            }
            
            tipLable.text = message
            
            if(imageName == ""){
                startAnimAction()
                return
            }
            
            iconView.image = UIImage(named: imageName)
            hoseIconView.isHidden = true
            maskIconView.isHidden = true
            
            
            
            
        
        }
    }
    
    
   override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    //旋转动画
    private func startAnimAction(){
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        anim.toValue = 2 * M_PI
        anim.repeatCount = MAXFLOAT
        anim.duration = 15;
        //动画完成不删除,如果imageview消失,将会跟随一起销毁
        anim.isRemovedOnCompletion = false
        iconView.layer.add(anim, forKey: nil)
    }
    

}

extension VisitView{
    
    fileprivate func setupUI(){
         backgroundColor = UIColor.cz_color(withHex: 0xEDEDED)
        
        addSubview(iconView)
        addSubview(maskIconView)
        addSubview(hoseIconView)
        
        addSubview(tipLable)
        addSubview(registBtn)
        addSubview(loginBtn)
        
        
        tipLable.textAlignment = .center
        
        for v in subviews{
            v.translatesAutoresizingMaskIntoConstraints = false
        }
        
        
        addConstraint(NSLayoutConstraint(item: iconView,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .centerX,
                                         multiplier: 1.0,
                                         constant: 0))
        
        addConstraint(NSLayoutConstraint(item: iconView,
                                         attribute: .centerY,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .centerY,
                                         multiplier: 1.0,
                                         constant: -60))
        //小房子
        addConstraint(NSLayoutConstraint(item: hoseIconView,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: iconView,
                                         attribute: .centerX,
                                         multiplier: 1.0,
                                         constant: 0))
        
        addConstraint(NSLayoutConstraint(item: hoseIconView,
                                         attribute: .centerY,
                                         relatedBy: .equal,
                                         toItem: iconView,
                                         attribute: .centerY,
                                         multiplier: 1.0,
                                         constant: 0))
        //提示标签
        addConstraint(NSLayoutConstraint(item: tipLable,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: iconView,
                                         attribute: .centerX,
                                         multiplier: 1.0,
                                         constant: 0))
        
        addConstraint(NSLayoutConstraint(item: tipLable,
                                         attribute: .top,
                                         relatedBy: .equal,
                                         toItem: iconView,
                                         attribute: .bottom,
                                         multiplier: 1.0,
                                         constant: 20))
        addConstraint(NSLayoutConstraint(item: tipLable,
                                         attribute: .width,
                                         relatedBy: .equal,
                                         toItem: nil,
                                         attribute: .notAnAttribute,
                                         multiplier: 1.0,
                                         constant: 236))
        //注册按钮
        
        addConstraint(NSLayoutConstraint(item: registBtn,
                                         attribute: .left,
                                         relatedBy: .equal,
                                         toItem: tipLable,
                                         attribute: .left,
                                         multiplier: 1.0,
                                         constant: 0))
        
        
        addConstraint(NSLayoutConstraint(item: registBtn,
                                         attribute: .top,
                                         relatedBy: .equal,
                                         toItem: tipLable,
                                         attribute: .bottom,
                                         multiplier: 1.0,
                                         constant: 20.0))
        
        addConstraint(NSLayoutConstraint(item: registBtn,
                                         attribute: .width,
                                         relatedBy: .equal,
                                         toItem: nil,
                                         attribute: .notAnAttribute,
                                         multiplier: 1.0,
                                         constant: 100))
        
        //登陆按钮
        
        addConstraint(NSLayoutConstraint(item: loginBtn,
                                         attribute: .right,
                                         relatedBy: .equal,
                                         toItem: tipLable,
                                         attribute: .right,
                                         multiplier: 1.0,
                                         constant: 0))
        
        
        addConstraint(NSLayoutConstraint(item: loginBtn,
                                         attribute: .top,
                                         relatedBy: .equal,
                                         toItem: tipLable,
                                         attribute: .bottom,
                                         multiplier: 1.0,
                                         constant: 20.0))
        
        addConstraint(NSLayoutConstraint(item: loginBtn,
                                         attribute: .width,
                                         relatedBy: .equal,
                                         toItem: nil,
                                         attribute: .notAnAttribute,
                                         multiplier: 1.0,
                                         constant: 100))
    
        let viewDict = ["maskIconView" : maskIconView,
                        "registBtn" : registBtn] as [String : Any]
        
        let metrics = ["spacing" : -20]
        
        
        
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-0-[maskIconView]-0-|",
             options: [],
             metrics: nil,
             views: viewDict))
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-0-[maskIconView]-(spacing)-[registBtn]",
            options: [],
            metrics: metrics,
            views: viewDict))
    }
    
}
