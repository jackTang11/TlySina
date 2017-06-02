//
//  RecommendGameViewCell.swift
//  TlyDou
//
//  Created by jack_tang on 17/5/9.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

import UIKit
import Kingfisher
class RecommendGameViewCell: UICollectionViewCell {

    @IBOutlet weak var Namelable: UILabel!
    @IBOutlet weak var imageV: UIImageView!
    
    var baseGame : BaseGameModel?{
        
        didSet{
        
            Namelable.text = baseGame?.tag_name
            
            guard let url = URL(string: (baseGame?.icon_url)!) else { return  }
            
            imageV.kf.setImage(with: url)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
       imageV.layer.cornerRadius = imageV.frame.width * 0.5
        imageV.layer.masksToBounds = true
    }

}
