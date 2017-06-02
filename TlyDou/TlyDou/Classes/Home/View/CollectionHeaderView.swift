//
//  CollectionHeaderView.swift
//  TlyDou
//
//  Created by jack_tang on 17/5/8.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {
    
   
    @IBOutlet weak var iconV: UIImageView!
    
    @IBOutlet weak var titleLable: UILabel!
    
    
    @IBOutlet weak var moreLable: UIButton!
    var anchorGroup : AnchorGroup?{
        didSet{
            titleLable.text = anchorGroup?.tag_name
            iconV.image = UIImage(named:anchorGroup?.icon_name ?? "home_header_normal")
           
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
         iconV.contentMode = .scaleAspectFit
        
    }
    
    class func collectionHeaderView() -> CollectionHeaderView{
        return Bundle.main.loadNibNamed("CollectionHeaderView", owner: nil, options: nil)?.first as! CollectionHeaderView
    }
    
    
    
}
