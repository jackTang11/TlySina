//
//  FunnyViewController.swift
//  TlyDou
//
//  Created by jack_tang on 17/5/11.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

import UIKit

class FunnyViewController: UIViewController {
    
    fileprivate var animImage : UIImageView = {
        let animImage = UIImageView(image: UIImage(named: "img_loading_1"))
        animImage.animationDuration = 0.5
        animImage.animationImages = [ UIImage(named: "img_loading_1")!, UIImage(named: "img_loading_2")!]
        animImage.animationRepeatCount = LONG_MAX
        animImage.autoresizingMask = [.flexibleWidth,.flexibleHeight]
       
        return animImage
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(animImage)
        animImage.center = self.view.center
        animImage.contentMode = .scaleAspectFill
        animImage.startAnimating()
        
    }

}
