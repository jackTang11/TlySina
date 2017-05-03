//
//  WBWelcomView.swift
//  TlySina
//
//  Created by jack_tang on 17/5/2.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

import UIKit

class WBWelcomView: UIView {


//   class func welcomView() -> WBWelcomView{
//      let nib =  UINib(nibName: "WBWelcomView", bundle: nil)
//      let v = nib.instantiate(withOwner: nil, options: nil)[0] as! WBWelcomView
//       v.frame = UIScreen.main.bounds
//    return v
//        
//    }
    @IBOutlet weak var iconView: UIImageView!
    
    @IBOutlet weak var nameLable: UILabel!
    
    @IBOutlet weak var bottomNum: NSLayoutConstraint!
    
    
    class func welcomView() -> WBWelcomView{
        let v =   Bundle.main.loadNibNamed("WBWelcomView", owner: nil, options: nil)?[0]  as! WBWelcomView
        v.frame = UIScreen.main.bounds
        return v
    }
    
    
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        self.layoutIfNeeded()

        
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: [], animations: {
            self.bottomNum.constant = self.bounds.size.height - 200
            self.layoutIfNeeded()
        }) { (_) in
           
            
            UIView.animate(withDuration: 1, animations: { 
                self.nameLable.alpha = 1
                self.layoutIfNeeded()
            }, completion: { (_) in
                self.removeFromSuperview()
            })
        }
        print(#function)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
         print(#function)
        
        
        iconView.layer.cornerRadius = iconView.bounds.size.height*0.5
        iconView.layer.masksToBounds = true
        
    }
    
    
}
