//
//  AmuseHeaderView.swift
//  TlyDou
//
//  Created by jack_tang on 17/5/11.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

import UIKit


fileprivate let cellIdentifier = "cell"

class AmuseHeaderView: UIView {
    
    var datas :[AnchorGroup]?{
    
        didSet{
            datas?.removeFirst()
         self.collectionV.reloadData()
        }
    }

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionV: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionV.register( UINib(nibName: "AmuseHeaderViewCell", bundle: nil)  , forCellWithReuseIdentifier: cellIdentifier)
        collectionV.backgroundColor = UIColor.white
        collectionV.isPagingEnabled = true
        collectionV.bounces = true
        
        autoresizingMask = .init(rawValue: 0)
        
     }
    

    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = collectionV.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionV.bounds.size

    }
    
}

extension AmuseHeaderView {

    class func createAmuseView() -> AmuseHeaderView{
        return Bundle.main.loadNibNamed("AmuseHeaderView", owner: nil, options: nil)?.first as! AmuseHeaderView
    
    }
}

extension AmuseHeaderView : UICollectionViewDataSource{

    

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        
        if(datas == nil) { return 0 }
        let number = (datas!.count - 1) / 8 + 1
        pageControl.numberOfPages = number
        return number
    }
    
    
    

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! AmuseHeaderViewCell
        setupCellData(cell: cell, indexPath: indexPath)
        return cell
    }
    
    
    func setupCellData(cell : AmuseHeaderViewCell, indexPath: IndexPath){
        let page  = indexPath.item
        //0  0-7
        //1  8-15
        //2  16 23
        
        let startN = page * 8
        var startEng = (page + 1) * 8 - 1
        
        
        if startEng > datas!.count - 1 {
            startEng = datas!.count - 1
        }
        
        cell.datas = Array(datas![startN...startEng])
        
    }
    
    
    
}
