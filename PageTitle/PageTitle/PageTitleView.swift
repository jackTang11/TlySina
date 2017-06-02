//
//  PageTitle.swift
//  PageTitle
//
//  Created by jack_tang on 17/5/18.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

import UIKit


protocol PageTitleViewDelegate : class {
    func titleClick(titleView: PageTitleView, clickIndex : Int)
}

class PageTitleView: UIView {
    
    fileprivate let style : TLYPageStyle
    fileprivate let title: [String]
    fileprivate var titleLable : [UILabel] = [UILabel]()
    fileprivate var currentIndex : Int = 0
    weak var delegate : PageTitleViewDelegate?
    fileprivate lazy var scrollview : UIScrollView = {
        let scrollview = UIScrollView(frame: self.bounds)
        scrollview.showsHorizontalScrollIndicator = false
        scrollview.scrollsToTop = false
        return scrollview
    }()
    
    init(frame: CGRect,titles: [String],style: TLYPageStyle) {
        self.style = style
        self.title = titles
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension PageTitleView : PageContentViewDeletega{

    // MARK : 添加UI
   fileprivate func setupUI(){
            addSubview(scrollview)
            setTitle()
            setTitleFrame()
    }
    
    
    // MARK :设置title
    private func setTitle(){
    
        for (i,item) in title.enumerated(){
            let label = UILabel()
            label.text = item
            label.font = UIFont.systemFont(ofSize: style.fontSize)
            label.textColor = (i == 0 ? style.selectColor : style.normalColor)
            label.tag = i
            label.textAlignment = .center
            scrollview.addSubview(label)
            self.titleLable.append(label)
            
             let tapGes = UITapGestureRecognizer(target: self, action: #selector(titleLabelClick(_:)))
             label.addGestureRecognizer(tapGes)
            label.isUserInteractionEnabled = true
        }
        
    }
    
    
    
    
    private func setTitleFrame(){
    
        var lablex: CGFloat = 0
        let labley: CGFloat = 0
        var lablew: CGFloat = 0
        var lableh: CGFloat = 0
        let count = title.count
        for (i,item) in titleLable.enumerated(){
            lableh = bounds.height
            if(style.isScrollEnable){
                let size = CGSize(width: CGFloat(MAXFLOAT), height: 0)
                //计算单个宽度
               lablew = (title[i] as NSString).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName : item.font], context: nil).width
                if(i == 0){
                    lablex  = style.itemMargin * 0.5
                }else{
                    let preLable = titleLable[ i-1]//求出上一个lable  拿到最大X+margin
                    lablex =   preLable.frame.maxX + style.itemMargin
                }
                
            }else{
                lablew = bounds.width / CGFloat(count)
                lablex = CGFloat(i) * lablew
            }
            item.frame = CGRect(x: lablex, y: labley, width: lablew, height: lableh)
        }
        

        //如果可以滑动就取出最后一个lable的最大X值,然后再加上margin,如果不可以滚动,只需要设置CGSize.zero

        scrollview.contentSize =
        style.isScrollEnable ? CGSize(width: titleLable.last!.frame.maxX + style.itemMargin, height: 0) : CGSize.zero
        
    }
    
    
   @objc fileprivate func titleLabelClick(_ tap : UITapGestureRecognizer){
        let tapView = tap.view as! UILabel
        let index = tapView.tag
        scrollToIndex(index)
      delegate?.titleClick(titleView: self, clickIndex: currentIndex)
    }
    
    // MARK :滚动到指定位置
    private func scrollToIndex(_ index : Int){
         if index == currentIndex { return }
        
        let targetLabel = titleLable[index]
        let sourceLabel = titleLable[currentIndex]
        
        targetLabel.textColor =  style.selectColor
        sourceLabel.textColor =  style.normalColor
        
        currentIndex = index
        
        //滚动标题到中间
        if(style.isScrollEnable){
            var offset = targetLabel.center.x -  scrollview.bounds.width * 0.5
            if offset < 0{
                offset = 0
            }
            
            if offset > (scrollview.contentSize.width - scrollview.bounds.width){
                
                offset = scrollview.contentSize.width - scrollview.bounds.width
            }
            scrollview.setContentOffset(CGPoint(x: offset, y: 0), animated: true)
            
        }
        
    }
    
    
    func titleScroll(content: PageContentView, index: Int, progress: CGFloat) {
        let targetLabel = titleLable[index]
        let sourceLabel = titleLable[currentIndex]
        
        // 2.颜色渐变
        let deltaRGB = UIColor.getRGBDelta(style.selectColor, style.normalColor)
        let selectRGB = style.selectColor.getRGB()
        let normalRGB = style.normalColor.getRGB()
        targetLabel.textColor = UIColor(r: normalRGB.0 + deltaRGB.0 * progress, g: normalRGB.1 + deltaRGB.1 * progress, b: normalRGB.2 + deltaRGB.2 * progress)
        sourceLabel.textColor = UIColor(r: selectRGB.0 - deltaRGB.0 * progress, g: selectRGB.1 - deltaRGB.1 * progress, b: selectRGB.2 - deltaRGB.2 * progress)
        
        
    }
    
    
    // MARK : content 的代理
    func titleScroll(content: PageContentView, index: Int) {
        scrollToIndex(index)
    }
    
    

    
}




