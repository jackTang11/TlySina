//
//  UIBarButtonItem-Extension.swift
//  TlyDou
//
//  Created by jack_tang on 17/5/5.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

import UIKit

extension UIBarButtonItem {

    convenience init(imageName : String ,heightImage :String = "",size : CGSize = CGSize.zero){
        let btn = UIButton()
        
        btn.setImage(UIImage(named: imageName), for: .normal)
        
        if heightImage != "" {
            btn.setImage(UIImage(named: heightImage), for: .highlighted)
        }
        
        if size == CGSize.zero{
            btn.sizeToFit()
        }else{
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        self.init(customView: btn)
    }
}
