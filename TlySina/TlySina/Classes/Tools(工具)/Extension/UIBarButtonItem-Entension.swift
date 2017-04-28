//
//  UIBarButtonItem-Entension.swift
//  TlySina
//
//  Created by jack_tang on 17/4/28.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

import UIKit

extension UIBarButtonItem{

    convenience init(title: String , fontSize: CGFloat = 16 ,_ target: Any?, action: Selector ,_ isBack: Bool = true) {
        let btn : UIButton = UIButton.cz_textButton(title, fontSize: fontSize, normalColor: UIColor.darkGray,
                                                    highlightedColor: UIColor.orange )
        btn.addTarget(target, action: action, for: .touchUpInside)
        
        
        if(isBack){
            btn.setImage(UIImage(named: "navigationbar_back_withtext"), for: .normal)
            btn.setImage(UIImage(named: "navigationbar_back_withtext_highlighted"), for: .highlighted)
            btn.sizeToFit()
        }
        self.init(customView : btn)
    }

}
