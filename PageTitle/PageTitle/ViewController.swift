//
//  ViewController.swift
//  PageTitle
//
//  Created by jack_tang on 17/5/18.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController{
  
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    var dataListLeft : UITableView!
    var dataListRight : UITableView!
    var selectLineNum = 0
    
    fileprivate lazy var getTopView :UIImageView = {
        
        let imgView = UIImageView(image: UIImage.init(named: "顶部焦点图"))
        imgView.frame = CGRect(x: 0, y: 0, width: self.screenWidth, height: self.screenWidth*27/75)
        
        let searchButton = UIButton()
        imgView.addSubview(searchButton)
        searchButton.snp.makeConstraints { (make) in
            make.edges.equalTo(imgView).inset(UIEdgeInsets(top: (imgView.frame.size.height-30)*156/210, left: self.screenWidth/10, bottom: (imgView.frame.size.height-30)*54/210, right: self.screenWidth/10))
        }
        searchButton.backgroundColor = UIColor(colorLiteralRed: 0, green: 0, blue: 0, alpha: 0.6)
        searchButton.layer.cornerRadius = 15
        searchButton.addTarget(self, action: #selector(searchClick), for: UIControlEvents.touchUpInside)
        
        
        
        let icon = UIImageView()
        searchButton.addSubview(icon)
        
        icon.backgroundColor = UIColor.red
        icon.snp.makeConstraints { (make) in
            make.left.equalTo(searchButton).offset(10)
            make.top.equalTo(searchButton).offset(10)
            make.width.height.equalTo(10)
        }
        
        return imgView
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
      
    }

    
}

extension ViewController{

    fileprivate func setupUI(){
        let topView = self.getTopView
        self.view.addSubview(self.getTopView)
        self.dataListLeft = UITableView(frame: CGRect(x: 0, y: topView.frame.size.height, width: 170.0/2, height: screenHeight-topView.frame.size.height), style: UITableViewStyle.plain)
        self.dataListLeft.delegate = self;
        self.dataListLeft.dataSource = self;
        self.view.addSubview(self.dataListLeft)
        
        
        self.dataListRight = UITableView(frame: CGRect(x: self.dataListLeft.frame.size.width, y: topView.frame.size.height, width: screenWidth-self.dataListLeft.frame.size.width, height: screenHeight-topView.frame.size.height), style: UITableViewStyle.plain)
        self.dataListRight.delegate = self;
        self.dataListRight.dataSource = self;
        self.view.addSubview(self.dataListRight)
    }
}



extension ViewController{

    func searchClick(){
        
    }
    

}

extension ViewController : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == self.dataListLeft {
            return 50
        }else{
            return 88
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 22
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.dataListLeft {
            var cell : LeftTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "left") as? LeftTableViewCell
            if cell == nil {
                cell = LeftTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "left")
            }
            cell?.updateCell(numLine: selectLineNum, selectLine: indexPath.row)
            return cell!
            
        }else{
            var cell = tableView.dequeueReusableCell(withIdentifier: "right")
            if cell == nil {
                cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "right")
            }
            return cell!
            
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == self.dataListLeft {
            selectLineNum = indexPath.row
            self.dataListLeft.reloadData()
        }
        
    }

}


