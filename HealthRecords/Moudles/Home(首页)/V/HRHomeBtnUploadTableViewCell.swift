//
//  HRHomeBtnUploadTableViewCell.swift
//  HealthRecords
//
//  Created by kys-3 on 2018/4/24.
//  Copyright © 2018年 kys-20. All rights reserved.
//

import UIKit

class HRHomeBtnUploadTableViewCell: UITableViewCell {

    var txtLabel : UILabel?
    var detailLabel : UILabel?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: "CellID")
        self.SetUpUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func SetUpUI(){
        txtLabel = UILabel()
        self.addSubview(txtLabel!)
        txtLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(self).offset(12)
            make.top.equalTo(self).offset(18)
            make.width.equalTo(130)
            make.height.equalTo(25)
        })
        detailLabel = UILabel()
        detailLabel?.textColor = UIColor.lightGray
        detailLabel?.textAlignment = .right
        self.addSubview(detailLabel!)
        detailLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.snp.right).offset(-160)
            make.top.equalTo(txtLabel!)
            make.width.equalTo(120)
            make.height.equalTo(25)
            
        })
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
