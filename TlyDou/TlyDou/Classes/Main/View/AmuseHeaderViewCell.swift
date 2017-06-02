//
//  AmuseHeaderViewCell.swift
//  TlyDou
//
//  Created by jack_tang on 17/5/11.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

import UIKit


fileprivate let Identifier = "Identifier"

class AmuseHeaderViewCell: UICollectionViewCell {
    
    var datas :[AnchorGroup]?{
        didSet{
            self.collectionV.reloadData()
        }
    }
    

    @IBOutlet weak var collectionV: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
    
        collectionV.register(UINib(nibName: "RecommendGameViewCell", bundle: nil), forCellWithReuseIdentifier: Identifier)
      
    }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let layout =  collectionV.collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = .horizontal
        let itemW = collectionV.bounds.width / 4
        let itemH = collectionV.bounds.height / 2
        layout.itemSize = CGSize(width: itemW, height: itemH)
       
    }

}

extension AmuseHeaderViewCell : UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        return datas?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifier, for: indexPath) as! RecommendGameViewCell
        cell.baseGame = datas![indexPath.item]
        return cell
    }
    
}
