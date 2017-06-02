//
//  CollectionPrettyCell.swift
//  TlyDou
//
//  Created by jack_tang on 17/5/8.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

import UIKit

class CollectionPrettyCell: CollectionBaseCell {
    
    
    @IBOutlet weak var imageV: UIImageView!

    @IBOutlet weak var titleName: UILabel!
    @IBOutlet weak var numberAline: UILabel!
    @IBOutlet weak var loaction: UILabel!
    
    
    override var anchor : AnchorModel?{
        didSet{
            super.anchor = anchor
            
            guard let anchor = anchor else { return}
            
            
            
            var onlineStr : String = ""
            
            if anchor.online >= 10000 {
                onlineStr = " \(Int(anchor.online / 10000))万人在线 "
            }else{
                onlineStr = " \(anchor.online)人在线 "
            }
            
            loaction.text = anchor.anchor_city
            
            numberAline.text = onlineStr
            titleName.text = anchor.nickname
            guard let iconUrl = URL(string: anchor.vertical_src) else { return}
            imageV.kf.setImage(with: iconUrl)
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageV.layer.cornerRadius = 5
        imageV.layer.masksToBounds = true
        
        numberAline.layer.cornerRadius = 2
        numberAline.layer.masksToBounds = true
    }

}
