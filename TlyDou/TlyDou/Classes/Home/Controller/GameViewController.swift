//
//  GameViewController.swift
//  TlyDou
//
//  Created by jack_tang on 17/5/10.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

import UIKit

 let cellW : CGFloat = kScreenW / 3
let headercollectionH : CGFloat = 100
private let kHeaderViewH : CGFloat = 50
class GameViewController: UIViewController {
    
   lazy var gameModels = [BaseGameModel]()
    
    fileprivate lazy var collectionview : UICollectionView = {[unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
       layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        
        let collectionview = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionview.dataSource = self
         collectionview.backgroundColor = UIColor.white
        collectionview.delegate = self
        collectionview.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        collectionview.register( UINib(nibName: "RecommendGameViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        collectionview.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headCell")
        
        return collectionview
    }()
    

    
    fileprivate lazy var headercollectionview : UICollectionView = {[unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
    
        let headercollectionview = UICollectionView(frame: CGRect(x: 0, y: -headercollectionH, width: kScreenW, height: headercollectionH), collectionViewLayout: layout)
        headercollectionview.dataSource = self
         headercollectionview.backgroundColor = UIColor.white
        headercollectionview.bounces = true
        headercollectionview.delegate = self
        headercollectionview.register( UINib(nibName: "RecommendGameViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        headercollectionview.showsVerticalScrollIndicator = false
        headercollectionview.showsHorizontalScrollIndicator = false
        return headercollectionview
    }()
    
    
    fileprivate lazy var gameModelHttp = GameViewModel()
    
    fileprivate lazy var topHeadView : CollectionHeaderView = {
        let topHeadView = CollectionHeaderView.collectionHeaderView()
        topHeadView.titleLable.text = "常见"
        topHeadView.iconV.image = UIImage(named: "Img_orange")
        topHeadView.moreLable.isHidden = true
        topHeadView.frame = CGRect(x: 0, y: -(headercollectionH + kHeaderViewH), width: kScreenW, height: kHeaderViewH)
        return topHeadView
        
    }()
    
    fileprivate lazy var recommons = [BaseGameModel]()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        loadData()
    }

}

extension GameViewController {

    fileprivate func setUI(){
        collectionview.addSubview(topHeadView)
        collectionview.addSubview(headercollectionview)
        collectionview.contentInset = UIEdgeInsets(top: headercollectionH + kHeaderViewH , left: 0, bottom: 0, right: 0)
        self.view.addSubview(collectionview)
    }
    
    fileprivate func loadData(){
            gameModelHttp.loadGameData {[weak self] in
            self?.gameModels = (self?.gameModelHttp.gameModels)!
            self?.collectionview.reloadData()
                 self?.headercollectionview.reloadData()
        }
    
    }

}


extension GameViewController : UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout {


    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return gameModels.count
    }
    
    
    
    public func collectionView(_ collview: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
           let cell = collview.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! RecommendGameViewCell
            cell.baseGame = gameModels[indexPath.item]
        return cell
    }
    
    
    func collectionView(_ collview: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = collview.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headCell", for: indexPath) as! CollectionHeaderView
        cell.moreLable.isHidden = true
        cell.titleLable.text = "全部"
        cell.iconV.image = UIImage(named: "Img_orange")
        return cell
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int{
        return 1
    }
    
    func collectionView(_ collview: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collview == headercollectionview{
           return CGSize(width: 85, height: 85)
        }else{
           return CGSize(width: cellW, height: 85)
        }
    }

    
}
