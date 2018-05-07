//
//  HRUserClickTableViewCell.swift
//  HealthRecords
//
//  Created by kys-3 on 2018/4/26.
//  Copyright © 2018年 kys-20. All rights reserved.
//

import UIKit

class HRUserClickTableViewCell: UITableViewCell {

    
    var avatorImage : UIImageView!
    var txtLabel : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        self.setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setUI(){
        
        avatorImage = UIImageView()
        avatorImage.image = UIImage(named: "头像 女孩")
        self.addSubview(avatorImage)
        avatorImage.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.right).offset(-90)
            make.top.equalTo(11)
            make.size.equalTo(50)
        }
        txtLabel = UILabel()
        txtLabel.text = "头像"
//        txtLabel.font = UIFont.systemFont(ofSize: 20)
        self.addSubview(txtLabel!)
        txtLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(self).offset(19)
            make.top.equalTo(self).offset(20)
            make.width.equalTo(130)
            make.height.equalTo(30)
        })
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
