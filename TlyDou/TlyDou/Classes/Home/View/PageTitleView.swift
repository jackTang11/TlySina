//
//  PageTitleView.swift
//  TlyDou
//
//  Created by jack_tang on 17/5/5.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

import UIKit


private let kScrollLineH : CGFloat = 2



protocol PageTitleViewDelegate : class {
    func setSelectTitle(title : PageTitleView ,index : Int)
}


class PageTitleView: UIView {

    fileprivate var titles : [String]
    
    //存储上面lable的顺序
    fileprivate lazy var titleLables = [UILabel]()

    //定义常量
    fileprivate let kNormalColor : (CGFloat , CGFloat ,CGFloat) = (85,85,85)
    fileprivate let kSelector : (CGFloat ,CGFloat ,CGFloat) = (255,128,0)
    
    //定义代理
    weak var titleDelegate : PageTitleViewDelegate?
    
    //当前选中索引
    fileprivate var currentIndex : Int = 0
    //懒加载一个 UIScrollView
    fileprivate lazy var scrollView : UIScrollView = {[weak self] in
        let scrollView = UIScrollView(frame: CGRect.zero)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        scrollView.scrollsToTop = false
        return scrollView
    }()
    
    //创建下划线
    fileprivate lazy  var  scrollLine : UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = .red
        return scrollLine
        
    }()
    
    init(frame: CGRect,titles: [String]) {
         self.titles = titles
         super.init(frame: frame)
         setupUI()
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


extension PageTitleView {
    //soureindex,targetIndex,progress
    
    func setSelectIndex(_ sourceindex : Int,_ targetIndex : Int,_ progress: CGFloat){
          
        // 1.取出sourceLabel/targetLabel
        let sourceLabel = titleLables[sourceindex]
        let targetLabel = titleLables[targetIndex]
        
        // 2.处理滑块的逻辑
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        
        // 3.颜色的渐变(复杂)
        // 3.1.取出变化的范围
        let colorDelta = (kSelector.0 - kNormalColor.0, kSelector.1 - kNormalColor.1, kSelector.2 - kNormalColor.2)
        
        // 3.2.变化sourceLabel
        sourceLabel.textColor = UIColor(r: kSelector.0 - colorDelta.0 * progress, g: kSelector.1 - colorDelta.1 * progress, b: kSelector.2 - colorDelta.2 * progress)
        
        // 3.2.变化targetLabel
        targetLabel.textColor = UIColor(r: kNormalColor.0 + colorDelta.0 * progress, g: kNormalColor.1 + colorDelta.1 * progress, b: kNormalColor.2 + colorDelta.2 * progress)
        
        // 4.记录最新的index
        currentIndex = targetIndex
        
    }
}

extension PageTitleView {

    fileprivate func setupUI(){
        addSubview(scrollView)
        scrollView.frame = bounds
        setupTitleLables()
        setupBottomlineAndScrollline()
    
    
    }
    
    
   @objc private func titleClick(_ tap : UITapGestureRecognizer){
        guard let currentLable = tap.view as? UILabel else{
            return
        }
    
    //上一次点击的那个
    titleLables[currentIndex].textColor = UIColor(r: kNormalColor.0,
                                                          g: kNormalColor.1,
                                                          b: kNormalColor.2)
        currentIndex = currentLable.tag
    
    //当前
     titleLables[currentIndex].textColor = UIColor(r: kSelector.0,
                                                      g: kSelector.1,
                                                      b: kSelector.2)
    
    //移动滑块
        UIView.animate(withDuration: 0.2) {
            self.scrollLine.frame.origin.x = currentLable.frame.origin.x
        }
    
    
     titleDelegate?.setSelectTitle(title: self, index: currentIndex)
    }
    
    
    
    //设置title
    private func setupTitleLables(){
        
        let lableW : CGFloat = bounds.width / CGFloat(self.titles.count)
        let lableH : CGFloat = bounds.height - kScrollLineH
        let lableY : CGFloat = 0
        
        for (index ,title) in self.titles.enumerated() {
            let lable = UILabel()
            
            lable.text = title
            lable.tag = index
            
            lable.font = UIFont.systemFont(ofSize: 16.0)
            
            lable.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            lable.textAlignment = .center
            lable.sizeToFit()
            let lableX = CGFloat(index) * lableW
            lable.frame = CGRect(x: lableX, y: lableY, width: lableW, height: lableH)
           
            scrollView.addSubview(lable)//添加到scrollView中
            titleLables.append(lable)
            
            //添加手势监听
            lable.isUserInteractionEnabled = true
            let gester = UITapGestureRecognizer(target: self, action:#selector(self.titleClick(_:)))
            lable.addGestureRecognizer(gester)
        }
        
        
        guard let firstLable = titleLables.first else {
            return
        }
        
        firstLable.textColor = UIColor(r: kSelector.0,
                                       g: kSelector.1,
                                       b: kSelector.2)
        
    }
    
    //添加定义的线段和滑块
    private func setupBottomlineAndScrollline(){
        //添加bottomline
        let bottomline = UIView()
         bottomline.backgroundColor = UIColor.lightGray
        let linH : CGFloat = 0.5
         bottomline.frame = CGRect(x: 0, y: bounds.height - linH, width: bounds.width, height: linH)
         addSubview(bottomline)
    

        scrollView.addSubview(scrollLine)
        guard let fristLable = titleLables.first else {
                return
        }
        scrollLine.frame = CGRect(x: fristLable.frame.origin.x,
                                  y: bounds.height - kScrollLineH,
                                  width: fristLable.bounds.width,
                                  height: kScrollLineH)
        
    }
    
}
