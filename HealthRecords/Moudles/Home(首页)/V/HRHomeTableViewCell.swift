//
//  HRHomeTableViewCell.swift
//  HealthRecords
//
//  Created by kys-20 on 2018/4/18.
//  Copyright © 2018年 kys-20. All rights reserved.
//

import UIKit
import Cards
class HRHomeTableViewCell: UITableViewCell
{
    
    
    var groupBtn: CardGroup?
    
    var groupBtn1: CardGroup?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpUI(imageName:String,titleName:String,subTitle:String,presentVC: UIViewController,FromVC:UIViewController) -> ()
    {
        groupBtn = CardGroup(frame:CGRect(x:40/640*WIDTH, y: 20, width: 250/640*WIDTH, height: 200))
        groupBtn?.title = titleName
        groupBtn?.subtitle = subTitle
//        groupBtn?.backgroundIV.kf.setImage(with: URL(string: imageName))
        groupBtn?.backgroundImage = UIImage(named: imageName)
        groupBtn?.shouldPresent(presentVC, from:FromVC)
        groupBtn?.layer.cornerRadius = 20
        groupBtn?.layer.masksToBounds = true
        self.addSubview(groupBtn!)
    }
    
    func setUpUI1(imageName:String,titleName:String,subTitle:String,presentVC: UIViewController,FromVC:UIViewController) -> ()
    {
        
        groupBtn1 = CardGroup(frame:CGRect(x:340/640*WIDTH, y: 20, width: 250/640*WIDTH, height: 200))
        groupBtn1?.title = titleName
        groupBtn1?.subtitle = subTitle
//        groupBtn1?.backgroundIV.kf.setImage(with: URL(string: imageName))
        groupBtn1?.backgroundImage = UIImage(named: imageName)
        groupBtn1?.shouldPresent(presentVC, from:FromVC)
        groupBtn1?.layer.cornerRadius = 20
        groupBtn1?.layer.masksToBounds = true
        self.addSubview(groupBtn1!)
    }
    
    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

