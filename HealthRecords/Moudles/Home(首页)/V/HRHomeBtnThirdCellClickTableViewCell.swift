//
//  HRHomeBtnThirdCellClickTableViewCell.swift
//  HealthRecords
//
//  Created by kys-3 on 2018/4/23.
//  Copyright © 2018年 kys-20. All rights reserved.
//

import UIKit

class HRHomeBtnThirdCellClickTableViewCell: UITableViewCell {
    
    var avatorImage : UIImageView!
    var txtLabel : UILabel!
    var modifierImage : UIImageView!
    var selectImage : UIImageView!
    var lovedOne: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        self.setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpUI(){
        avatorImage = UIImageView()
        avatorImage.image = UIImage(named: "头像.png")
        avatorImage.layer.cornerRadius = 10
        self.addSubview(avatorImage)
        avatorImage.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(10)
            make.top.equalTo(self).offset(13)
            make.size.equalTo(30)
        }
        txtLabel = UILabel()
        txtLabel.text = ""
        txtLabel.textColor = .black
        txtLabel.textAlignment = .left
        self.addSubview(txtLabel)
        txtLabel.snp.makeConstraints { (make) in
            make.left.equalTo(avatorImage.snp.right).offset(10)
            make.top.equalTo(avatorImage.snp.top)
            make.width.equalTo(60)
            make.height.equalTo(30)
        }
        selectImage = UIImageView()

        self.addSubview(selectImage)
        selectImage.snp.makeConstraints { (make) in
            make.top.equalTo(txtLabel.snp.top).offset(7)
            make.left.equalTo(self.snp.right).offset(-40)
            make.size.equalTo(20)
        }
        
        lovedOne = UILabel()
        lovedOne.text = ""
        lovedOne.textColor = .black
        lovedOne.textAlignment = .center
        self.addSubview(lovedOne)
        lovedOne.snp.makeConstraints { (make) in
            make.right.equalTo(self.snp.right).offset(0)
            make.top.equalTo(txtLabel.snp.top)
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
        
        
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
