//
//  TLYPageView.swift
//  PageTitle
//
//  Created by jack_tang on 17/5/18.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

import UIKit


class TLYPageView: UIView {
    
    fileprivate let style : TLYPageStyle
    fileprivate let title: [String]
    fileprivate let childvc : [UIViewController]
    fileprivate let parentVc : UIViewController
    fileprivate var titleView : PageTitleView!

    init(frame: CGRect,title: [String],childvc: [UIViewController],parentVc: UIViewController,style: TLYPageStyle) {
        self.style = style
        self.title = title
        self.childvc = childvc
        self.parentVc = parentVc
    
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension TLYPageView{

    
    fileprivate func setupUI(){
        setTitleView()
        setContentView()
    
    }
    
    private func  setTitleView(){
       let rect = CGRect(x: 0, y: 0, width: bounds.width, height: style.titleHeight)
        self.titleView = PageTitleView(frame: rect, titles: title, style: style)
        addSubview(titleView)
        titleView.backgroundColor = UIColor.randomColor()
    }
    
    private func setContentView(){
        let rect = CGRect(x: 0, y: style.titleHeight, width: bounds.width, height: bounds.height - style.titleHeight)
        let pageContent = PageContentView(frame: rect, childvc: childvc, parentVc: parentVc)
        addSubview(pageContent)
        self.titleView.delegate = pageContent
        pageContent.deletage = self.titleView
    }

}
