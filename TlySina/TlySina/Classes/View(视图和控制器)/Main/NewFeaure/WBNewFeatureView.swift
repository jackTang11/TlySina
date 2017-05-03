//
//  WBNewFeatureView.swift
//  TlySina
//
//  Created by jack_tang on 17/5/2.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

import UIKit

class WBNewFeatureView: UIView {

 
    @IBOutlet weak var scrollview: UIScrollView!

    @IBOutlet weak var pageContrillView: UIPageControl!
    
    @IBOutlet weak var goBtn: UIButton!
    
    @IBAction func goWb(_ sender: Any) {
        
        removeFromSuperview()
    }
    
    class func newFeature() -> WBNewFeatureView{
    
      let nib =  UINib(nibName: "WBNewFeatureView", bundle: nil)
      let v =  nib.instantiate(withOwner: nil, options: nil)[0] as! WBNewFeatureView
      v.frame = UIScreen.main.bounds
        return v
    }
    
    
    
    override func awakeFromNib() {
        let count = 4
        let rect = UIScreen.main.bounds
        for i in 0..<count {
            let imageName = "new_feature_\(i+1)"
            let image = UIImageView(image: UIImage(named: imageName))
            
            image.frame = rect.offsetBy(dx: rect.width * CGFloat(i), dy: 0)
            
            scrollview.addSubview(image)
            
        }
        
        
        scrollview.contentSize = CGSize(width: CGFloat(count+1) * rect.width, height: 0)
        scrollview.showsVerticalScrollIndicator = false
        scrollview.showsHorizontalScrollIndicator = false
        scrollview.isPagingEnabled = true
        scrollview.bounces = false
        scrollview.delegate = self
        goBtn.isHidden = true
        
    }
    
    

}


extension WBNewFeatureView : UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let current = CGFloat(scrollview.subviews.count) * UIScreen.main.bounds.width
        
        if(scrollView.contentOffset.x == current){
            self.removeFromSuperview()
        }
        
        
        if(scrollView.contentOffset.x == CGFloat(scrollview.subviews.count - 1) * UIScreen.main.bounds.width){
            self.goBtn.isHidden = false

        }else{
            self.goBtn.isHidden = true
        }
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        goBtn.isHidden = true
        pageContrillView.currentPage = Int(scrollview.contentOffset.x / UIScreen.main.bounds.width + 0.5)
        pageContrillView.isHidden = (pageContrillView.currentPage + Int(0.5) == scrollview.subviews.count)
        
    }
    

}




