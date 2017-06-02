//
//  CollectionCycleCell.swift
//  TlyDou
//
//  Created by jack_tang on 17/5/9.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

import UIKit

class CollectionCycleCell: UICollectionViewCell {

    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var titleLable: UILabel!
    
    
    var cycle : CycleModel?{
        didSet{
            titleLable.text = cycle?.title
            let iconURL = URL(string: cycle?.pic_url ?? "")!
            image.kf.setImage(with: iconURL, placeholder: UIImage(named: "Img_default"))
        }
    }

}
