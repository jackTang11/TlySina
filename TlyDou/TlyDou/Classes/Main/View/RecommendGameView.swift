//
//  RecommendGameView.swift
//  TlyDou
//
//  Created by jack_tang on 17/5/9.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

import UIKit

class RecommendGameView: UIView {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var groups : [BaseGameModel]?{
    
        didSet{
            collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        autoresizingMask = .init(rawValue: 0)
        
      let layout =  collectionView.collectionViewLayout as! UICollectionViewFlowLayout
                layout.minimumInteritemSpacing = 0
                layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 90, height: 90)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        collectionView.register(UINib(nibName: "RecommendGameViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
    }
}



extension RecommendGameView {

    class func recomGameView() -> RecommendGameView{
        return Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)?.first as! RecommendGameView
    }
}

extension RecommendGameView : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return groups?.count ?? 0
    }
    

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! RecommendGameViewCell
        cell.baseGame = groups?[indexPath.item]
        return cell
    }
    

}

