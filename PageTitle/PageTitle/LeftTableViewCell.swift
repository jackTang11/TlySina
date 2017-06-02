//
//  LeftTableViewCell.swift
//  目的地
//
//  Created by 张世良 on 2017/5/19.
//  Copyright © 2017年 Apple Inc. All rights reserved.
//

import UIKit

class LeftTableViewCell: UITableViewCell {

    var isSelecting : Bool = false
    fileprivate lazy var title: UILabel = {
        let title:UILabel = UILabel()
        title.font=UIFont.systemFont(ofSize: 15)
        title.textColor=UIColor.red
        title.frame = CGRect(x: 5, y: 15, width: 170/2-10, height: 20)
        title.text = "北郡华府"
        title.textAlignment = NSTextAlignment.center
        print("-----")
        return title
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(self.title)
    }
    
    func updateCell(numLine:Int,selectLine:Int){
        print(self.isHighlighted)
        if numLine == selectLine {
            self.title.textColor = UIColor.red
        }else{
            self.title.textColor = UIColor.black
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
