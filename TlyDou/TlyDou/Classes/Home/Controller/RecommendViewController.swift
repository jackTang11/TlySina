//
//  RecommendViewController.swift
//  TlyDou
//
//  Created by jack_tang on 17/5/8.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

import UIKit


private let kItemMargin : CGFloat = 10
private let kHeaderViewH : CGFloat = 50

private let kNormalCellID = "kNormalCellID"
private let kHeaderViewID = "kHeaderViewID"

private let kPrettyCellID = "kPrettyCellID"
private let kNormalItemW = (kScreenW - 3 * kItemMargin) / 2
private let kNormalItemH = kNormalItemW * 3 / 4
private let kPrettyItemH = kNormalItemW * 4 / 3
private let kGameViewH : CGFloat = 90


private let kCycleViewH = kScreenW * 3 / 8

class RecommendViewController: UIViewController {
    
    
    fileprivate lazy var anchorGroups = [AnchorGroup]()
    
    fileprivate lazy var reccommens = RecommendViewModel()
    //轮播
    fileprivate lazy var recommendCycle : RecommendCycleView = {
        let recommendCycle = RecommendCycleView.recommonCycleView()
        recommendCycle.frame = CGRect(x: 0, y: -(kCycleViewH + kGameViewH), width: kScreenW, height: kCycleViewH)
        recommendCycle.backgroundColor = UIColor.yellow
        return recommendCycle
    }()
    
    //游戏
    fileprivate lazy var recomGameView : RecommendGameView = {
        let recomGameView = RecommendGameView.recomGameView()
        recomGameView.frame = CGRect(x: 0, y: -kGameViewH  , width: kScreenW, height: kGameViewH)
        return recomGameView
    }()
    
    
    fileprivate lazy var collectionView : UICollectionView = {[unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kNormalItemW, height: kNormalItemH)
        layout.minimumLineSpacing = kItemMargin
        layout.minimumInteritemSpacing = kItemMargin
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
         collectionView.register( UINib(nibName: "CollectionHeaderView", bundle: nil),  forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self
       return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
      
    
    }

}

extension RecommendViewController {

    
    fileprivate func loadData(){
        
        self.reccommens.requestRecommenData{
            self.anchorGroups = self.reccommens.anchorGroups
            self.collectionView.reloadData()
            
            var games = [BaseGameModel]()
            for anchor in self.reccommens.anchorGroups {
              let ganme = BaseGameModel()
                ganme.icon_url = anchor.icon_url
                ganme.tag_name = anchor.tag_name
               games.append(ganme)
            }
            
            games.removeFirst()
            games.removeFirst()
            self.recomGameView.groups = games
            
        }
        
        self.reccommens.requestCycleData {
            self.recommendCycle.cycles = self.reccommens.cycleModels
        }
        
        
        
    }
    
    fileprivate func setupUI(){
        self.view.addSubview(collectionView)
        collectionView.addSubview(recommendCycle)
        collectionView.addSubview(recomGameView)
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH + kGameViewH , left: 0, bottom: 0, right: 0)
        
    }
}

extension RecommendViewController : UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout{

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return self.anchorGroups[section].anchors.count
    }
    
    

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let cell : CollectionBaseCell
        
         if(indexPath.section == 1){
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! CollectionPrettyCell
            cell.anchor = self.anchorGroups[indexPath.section].anchors[indexPath.item]
           return cell
        }else{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionNormalCell
            cell.anchor = self.anchorGroups[indexPath.section].anchors[indexPath.item]

            return cell
        }
    }

   public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        if(indexPath.section == 1){
            return CGSize(width: kNormalItemW, height: kPrettyItemH)
        }else{
            return CGSize(width: kNormalItemW, height: kNormalItemH)
        }
    
    }
    
   public func numberOfSections(in collectionView: UICollectionView) -> Int{
        return self.anchorGroups.count
    }
    
    
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView{
        let reusableview = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        reusableview.anchorGroup =  self.anchorGroups[indexPath.section]
        return reusableview
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           let model = self.anchorGroups[indexPath.section].anchors[indexPath.item]
        
        if(model.isVertical == 0){
           present(RoomShowViewController(), animated: true)
        }else{
         
          self.navigationController?.pushViewController(RoomNormalViewController(), animated: true)
        
        }
        
    }
    


}

