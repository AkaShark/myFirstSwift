//
//  HRScondTableViewCell.swift
//  HealthRecords
//
//  Created by kys-3 on 2018/4/26.
//  Copyright © 2018年 kys-20. All rights reserved.
//

import UIKit

class HRScondTableViewCell: UITableViewCell {

    var avatorImage : UIImageView!
    var txtLabel : UILabel!

    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        self.setUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setUI(){
        
        avatorImage = UIImageView()
        avatorImage.image = UIImage(named: "头像 男孩")
        self.addSubview(avatorImage)
        avatorImage.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(15)
            make.top.equalTo(10)
            make.size.equalTo(60)
        }
        txtLabel = UILabel()
        txtLabel.text = "用户名"
        txtLabel.font = UIFont.systemFont(ofSize: 20)
        self.addSubview(txtLabel!)
        txtLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(avatorImage.snp.right).offset(13)
            make.top.equalTo(avatorImage).offset(10)
            make.width.equalTo(130)
            make.height.equalTo(40)
        })
//        detaiLabel = UILabel()
//        detaiLabel?.textColor = UIColor.lightGray
//        detaiLabel?.textAlignment = .right
//        self.addSubview(detaiLabel!)
//        detaiLabel?.snp.makeConstraints({ (make) in
//            make.left.equalTo(self.snp.right).offset(-160)
//            make.top.equalTo(txtLabel!)
//            make.width.equalTo(120)
//            make.height.equalTo(25)
        
//        })
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
