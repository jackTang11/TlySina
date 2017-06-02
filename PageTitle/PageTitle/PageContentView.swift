//
//  PageContentView.swift
//  PageTitle
//
//  Created by jack_tang on 17/5/18.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

import UIKit

private let cellID = "Identifier"


protocol PageContentViewDeletega : class{
    func titleScroll(content : PageContentView,index: Int)
    func titleScroll(content : PageContentView,index: Int,progress : CGFloat)
}

class PageContentView: UIView {

    fileprivate let childvc : [UIViewController]
    fileprivate let parentVc : UIViewController
    weak var  deletage : PageContentViewDeletega?
    fileprivate var startOffsetX : CGFloat = 0
    fileprivate var isForbidScroll : Bool = false
    
    fileprivate  lazy var collection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        layout.itemSize = self.bounds.size
        
        let collection = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collection.dataSource = self
        collection.delegate = self
        collection.isPagingEnabled = true
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        collection.bounces = false
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        return collection
        
    }()
    
   init(frame: CGRect,childvc: [UIViewController],parentVc : UIViewController) {
        self.childvc = childvc
        self.parentVc = parentVc
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//MARK: UI设置
extension PageContentView{

    func setupUI(){
        addSubview(collection)
    }

}

//MARK: 数据源
extension PageContentView : UICollectionViewDataSource{

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return childvc.count
    }
    

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        let vcView = childvc[indexPath.item].view
        vcView?.frame = cell.bounds
        vcView?.backgroundColor = UIColor.randomColor()
        for item in cell.contentView.subviews{
            item.removeFromSuperview()
        }
        
        cell.contentView.addSubview(vcView!)
        
        return cell
    }

}

//MARK: collectionView 代理
extension PageContentView : UICollectionViewDelegateFlowLayout {

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        contentEndScroll()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            contentEndScroll()
        }
    }
    
    private func contentEndScroll() {
        guard !isForbidScroll else { return }
        
        // 1.获取滚动到的位置
        let currentIndex = Int(collection.contentOffset.x / collection.bounds.width)
        
        
        // 2.通知titleView进行调整
        deletage?.titleScroll(content: self, index: currentIndex)
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
         guard !isForbidScroll else { return }
        // 0.判断和开始时的偏移量是否一致
        guard startOffsetX != scrollView.contentOffset.x else {
            return
        }
        
        // 1.定义targetIndex/progress
        var targetIndex = 0
        var progress : CGFloat = 0.0
        
        // 2.给targetIndex/progress赋值
        let currentIndex = Int(startOffsetX / scrollView.bounds.width)
        if startOffsetX < scrollView.contentOffset.x { // 左滑动
            targetIndex = currentIndex + 1
            if targetIndex > childvc.count - 1 {
                targetIndex = childvc.count - 1
            }
            
            progress = (scrollView.contentOffset.x - startOffsetX) / scrollView.bounds.width
        } else { // 右滑动
            targetIndex = currentIndex - 1
            if targetIndex < 0 {
                targetIndex = 0
            }
            
            progress = (startOffsetX - scrollView.contentOffset.x) / scrollView.bounds.width
        }
        
        // 3.通知代理
        deletage?.titleScroll(content: self, index: targetIndex, progress: progress)

    }
}

//MARK: 自定义回调
extension PageContentView : PageTitleViewDelegate{
    // MARK :滚动到指定位置
    func titleClick(titleView: PageTitleView, clickIndex: Int) {
        isForbidScroll = true
        let indexPath = IndexPath(item: clickIndex, section: 0)
        
        collection.scrollToItem(at: indexPath, at: .left, animated: false)
    }

}








