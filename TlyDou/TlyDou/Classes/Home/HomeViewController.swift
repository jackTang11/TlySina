//
//  HomeViewController.swift
//  TlyDou
//
//  Created by jack_tang on 17/5/5.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

import UIKit


private let kTitleH : CGFloat = 60.0

class HomeViewController: UIViewController {

    
    fileprivate lazy var pageTileView : PageTitleView = {[weak self] in
        let rect = CGRect(x: 0, y: kNavGaitionBarH + kStatusH, width: kScreenW, height: kTitleH)
        let pageTileView = PageTitleView(frame: rect, titles: ["推荐","游戏","趣玩","娱乐"])
        pageTileView.titleDelegate = self
        return pageTileView
        
    }()
    
    
    
    fileprivate lazy var pageContentView: PageContentView = {[weak self] in
        
        let contentH = kScreenH - kNavGaitionBarH - kStatusH - kTitleH - kTabBarH
        
        let frame = CGRect(x: 0, y:  (kNavGaitionBarH + kStatusH + kTitleH), width: kScreenW, height: contentH)
       
        var childVcs : [UIViewController] = [UIViewController]()
         childVcs.append(RecommendViewController())
         childVcs.append(GameViewController())
         childVcs.append(AmuseViewController())
         childVcs.append(FunnyViewController())
         let pageContentView = PageContentView(rect: frame, vcs: childVcs, parentViewController: self)
        
        pageContentView.contentDeletage = self
        return pageContentView
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 0.不需要调整UIScrollView的内边距
        automaticallyAdjustsScrollViewInsets = false
        setupNavigationBar()
        
        self.view.addSubview(pageTileView)
        self.view.addSubview(pageContentView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension HomeViewController{
    
    //设置头部
    fileprivate func setupNavigationBar(){
        let size = CGSize(width: 40, height: 40)
       //设置左边Item
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        
        let historyItem = UIBarButtonItem(imageName: "image_my_history", heightImage: "Image_my_history_click", size: size)
        
        let searchItem = UIBarButtonItem(imageName: "btn_search", heightImage: "btn_search_clicked", size: size)
        
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", heightImage: "Image_scan_click", size: size)
        //设置右边按钮
        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrcodeItem]
        
    }

}


extension HomeViewController : PageContentViewDelagate {
    
    func setSelectIndex(pageContent: PageContentView, index: Int) {
//         pageTileView.setSelectIndex(index)
    }

    func setSelectIndex(pageContent: PageContentView, soureindex: Int, targetIndex: Int, progress: CGFloat) {
        pageTileView.setSelectIndex(soureindex,targetIndex,progress)
    }
    
}


extension HomeViewController : PageTitleViewDelegate{
    //回调当前选中
    func setSelectTitle(title: PageTitleView, index: Int) {
                 pageContentView.setSelectIndex(selectIndex: index)
    }

}







