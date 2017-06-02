//
//  AmuseViewController.swift
//  TlyDou
//
//  Created by jack_tang on 17/5/10.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

import UIKit


private let kItemMargin : CGFloat = 10
private let kHeaderViewH : CGFloat = 50
private let kNormalItemW = (kScreenW - 3 * kItemMargin) / 2
private let kNormalItemH = kNormalItemW * 3 / 4
private let kPrettyItemH = kNormalItemW * 4 / 3

private let kMenuViewH : CGFloat = 200
class AmuseViewController: UIViewController {

    fileprivate lazy var amuseModelHttp = AmuseViewModel()
    
     fileprivate lazy var datas = [AnchorGroup]()
    
    fileprivate lazy var collectionV : UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: kNormalItemW, height: kNormalItemH)
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)

        let collectionV = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionV.backgroundColor = UIColor.white
        collectionV.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        collectionV.dataSource = self
        collectionV.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        
         collectionV.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "UICollectionReusableView")
         collectionV.contentInset = UIEdgeInsets(top: kMenuViewH, left: 0, bottom: 0, right: 0)
        return collectionV
    }()
    

    
    fileprivate lazy var amuseHeaderView : AmuseHeaderView = {
        let amuseHeaderView = AmuseHeaderView.createAmuseView()
        amuseHeaderView.frame = CGRect(x: 0, y: -kMenuViewH, width: kScreenW, height: kMenuViewH)
        return amuseHeaderView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        loadData()
    }
}

extension AmuseViewController {
    
    func setUI(){
        self.view.addSubview(collectionV)
        collectionV.addSubview(amuseHeaderView)
    }
    
    
    func loadData(){
        amuseModelHttp.loadAmuseData { 
            self.datas = self.amuseModelHttp.datas
            self.collectionV.reloadData()
            self.amuseHeaderView.datas = self.amuseModelHttp.datas
        }
    }

}

extension AmuseViewController : UICollectionViewDataSource {


    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return datas[section].anchors.count
    }
    

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionV.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionNormalCell
        cell.anchor = datas[indexPath.section].anchors[indexPath.row]
        return cell
    }
    

    public func numberOfSections(in collectionView: UICollectionView) -> Int{
        return datas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "UICollectionReusableView", for: indexPath) as! CollectionHeaderView
        cell.anchorGroup = datas[indexPath.section]
        return cell
    }

}
