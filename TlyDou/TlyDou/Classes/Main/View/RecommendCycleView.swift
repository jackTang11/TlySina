//
//  RecommendCycleView.swift
//  TlyDou
//
//  Created by jack_tang on 17/5/9.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

import UIKit

let cellIndetifier = "cellIndetifier"

class RecommendCycleView: UIView {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    var cycleTimer : Timer?
    
    var cycles : [CycleModel]?{
        didSet{
            self.collectionView.reloadData()
            
            // 2.设置pageControl个数
            pageControl.numberOfPages = cycles?.count ?? 0
            
            // 3.默认滚动到中间某一个位置
            let indexPath = IndexPath(item: (cycles?.count ?? 0) * 10, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
            removeCycleTime()
            addCycleTimer()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        autoresizingMask = .init(rawValue: 0)
        collectionView.register(UINib(nibName: "CollectionCycleCell", bundle: nil), forCellWithReuseIdentifier: cellIndetifier)
         let layout =  collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        collectionView.bounces = false
        collectionView.isPagingEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
    
        let layout =  collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
  
        
    }
}

extension RecommendCycleView {

    class func recommonCycleView() -> RecommendCycleView{
        return Bundle.main.loadNibNamed("RecommendCycleView", owner: self, options: nil)?.first as! RecommendCycleView
    }
}

extension RecommendCycleView : UICollectionViewDataSource {

    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return (self.cycles?.count ?? 0) * 10000
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIndetifier, for: indexPath) as! CollectionCycleCell
         cell.cycle = cycles![(indexPath as NSIndexPath).item % cycles!.count]
        return cell
    }
    
}

extension RecommendCycleView : UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        pageControl.currentPage = Int(offset / scrollView.bounds.width) % (cycles?.count ?? 1)
    }
    
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        removeCycleTime()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        addCycleTimer()
    }
    
    
    fileprivate func addCycleTimer(){
        cycleTimer =  Timer(timeInterval: 3.0, target: self, selector: #selector(self.scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(cycleTimer!, forMode: .commonModes)
        
    }
    
    fileprivate func removeCycleTime(){
        cycleTimer?.invalidate()
        cycleTimer = nil
    }
    
    @objc fileprivate func scrollToNext(){
        // 1.获取滚动的偏移量
        let currentOffsetX = collectionView.contentOffset.x
        let offsetX = currentOffsetX + collectionView.bounds.width
        
        // 2.滚动该位置
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
    
    
    
}



