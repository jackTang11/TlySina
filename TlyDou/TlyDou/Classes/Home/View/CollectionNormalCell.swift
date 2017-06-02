//
//  CollectionNormalCell.swift
//  TlyDou
//
//  Created by jack_tang on 17/5/8.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionNormalCell: CollectionBaseCell {

    @IBOutlet weak var imageV: UIImageView!
    
    @IBOutlet weak var titleName: UILabel!
    
    @IBOutlet weak var descName: UILabel!
    
    @IBOutlet weak var numberLine: UIButton!
    
    
   override var anchor : AnchorModel?{
        didSet{
            super.anchor = anchor
            
            guard let anchor = anchor else { return}
            
            
            
            var onlineStr : String = ""
            
            if anchor.online >= 10000 {
                onlineStr = "\(Int(anchor.online / 10000))万人在线"
            }else{
                onlineStr = "\(anchor.online)人在线"
            }
            
            numberLine.setTitle(onlineStr, for: .normal)
            
            titleName.text = anchor.room_name
            descName.text = anchor.nickname
            
            guard let iconUrl = URL(string: anchor.vertical_src) else { return}
            imageV.kf.setImage(with: iconUrl)
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageV.layer.cornerRadius = 5
        imageV.layer.masksToBounds = true
    }
    
    
    

}
