//
//  HRMyInformationTableViewCell.swift
//  HealthRecords
//
//  Created by kys-3 on 2018/4/16.
//  Copyright © 2018年 kys-20. All rights reserved.
//

import UIKit

class HRMyInformationTableViewCell: UITableViewCell {

    var avatorImage : UIImageView!
    var titleLabel : UILabel!
    var approveLabel : UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() -> () {
        avatorImage = UIImageView()
        avatorImage.layer.cornerRadius = 4
        self.addSubview(avatorImage)
        
        avatorImage.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(20)
            make.top.equalTo(self).offset(20)
            make.size.equalTo(20)
        }
        
        titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        self.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(avatorImage.snp.right).offset(15)
            make.top.equalTo(avatorImage)
            make.width.equalTo(200)
            make.height.equalTo(20)
            
        }
        approveLabel = UILabel()
        self.addSubview(approveLabel)
        approveLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(3)
            make.width.equalTo(titleLabel)
            make.height.equalTo(titleLabel).offset(-5)
        }
    }
    
    func upDataWithArray(array:Array<Any>,imageArray:Array<Any>,index:IndexPath) -> () {
        var dataArray:Array! = array[0] as?Array<String>
        var imageArr:Array! = imageArray[0] as? Array<String>
        titleLabel?.text = dataArray?[index.row]
        avatorImage?.image = UIImage(named: (imageArr?[index.row])!)
    }
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
