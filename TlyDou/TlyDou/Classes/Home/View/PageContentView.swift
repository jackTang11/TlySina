//
//  PageContentView.swift
//  TlyDou
//
//  Created by jack_tang on 17/5/6.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

import UIKit


fileprivate  let  cellIdentifier : String = "cellIdentifier"


protocol PageContentViewDelagate : class {
    func setSelectIndex(pageContent : PageContentView, index : Int)
    func setSelectIndex(pageContent : PageContentView, soureindex : Int , targetIndex : Int , progress : CGFloat)
}

class PageContentView: UIView {

    
    fileprivate var viewControllers : [UIViewController]
    fileprivate var parentViewController: UIViewController?
    
    
    weak var contentDeletage : PageContentViewDelagate?
    
    fileprivate lazy var  collectionView : UICollectionView = { [weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        layout.itemSize = (self?.bounds.size)!
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.scrollsToTop = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        return collectionView
        
    }()
    
    
    init(rect: CGRect, vcs : [UIViewController] , parentViewController : UIViewController?) {
        self.viewControllers = vcs
        self.parentViewController = parentViewController
        super.init(frame: rect)
        setUpUI()
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


extension PageContentView {

    fileprivate func setUpUI(){
        //先把所有控制器添加到福控制器中
        for childVc in viewControllers {
            parentViewController?.addChildViewController(childVc)
        }
        
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}


//对外暴露的方法
extension PageContentView {

    func setSelectIndex(selectIndex index : Int){
        // 1.记录需要进制执行代理方法
        isForbidScrollDelegate = true
        collectionView.setContentOffset(CGPoint(x: CGFloat(index) * frame.width, y: 0), animated: true)
    }
    
}

fileprivate var startOffsetX : CGFloat = 0
var isForbidScrollDelegate : Bool = false

extension PageContentView : UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      let index =  collectionView.contentOffset.x / kScreenW
      contentDeletage?.setSelectIndex(pageContent: self, index: Int(index))
        
    }
    
    //记录按下的offsetx
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
         isForbidScrollDelegate = false
         startOffsetX = scrollView.contentOffset.x
    }
    
    

    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // 0.判断是否是点击事件
        if isForbidScrollDelegate { return }
        
        //1.progess
        let currentX = scrollView.contentOffset.x
        // 1.定义获取需要的数据
        var progress : CGFloat = 0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        
        let scrollW = scrollView.bounds.width
        
        if(currentX > startOffsetX){//向左滑动
            
            progress = currentX / scrollW - floor(currentX / scrollW)
            
            sourceIndex = Int(currentX / scrollW)
            targetIndex = sourceIndex + 1
            
            //防止越界
            if targetIndex >= viewControllers.count {
                targetIndex = viewControllers.count - 1
            }
            
            
            // 4.如果完全划过去
            if currentX - startOffsetX == scrollW {
                progress = 1
                targetIndex = sourceIndex
            }
            
        }else{//向右滑动
        
            progress = 1 - (currentX / scrollW - floor(currentX / scrollW))
            targetIndex = Int(currentX / scrollW)
            sourceIndex = targetIndex + 1
            
            //防止越界
            if sourceIndex >= viewControllers.count {
                sourceIndex = viewControllers.count - 1
            }
        }
        
       
        contentDeletage?.setSelectIndex(pageContent: self, soureindex: sourceIndex, targetIndex: targetIndex, progress: progress)
        
        
    }
    
}


extension PageContentView : UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
      return  viewControllers.count
    }
    
  
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier:cellIdentifier, for: indexPath)
               let vc = self.viewControllers[indexPath.item]
                for v in cell.contentView.subviews{
                    v.removeFromSuperview()
                }
        
                vc.view.frame = cell.contentView.bounds
                cell.contentView.addSubview(vc.view)
             return cell
    }

}

