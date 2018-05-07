//
//  HRDatumTableViewCell.swift
//  HealthRecords
//
//  Created by kys-3 on 2018/4/20.
//  Copyright © 2018年 kys-20. All rights reserved.
//

import UIKit

class HRDatumTableViewCell: UITableViewCell {
    
    var leftImageView : UIImageView!
    
    var titleLabel : UILabel!
    
    var detailLabel : UILabel!
    
    let LabelWidth = 443/630*WIDTH
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func  setupUI() -> () {
        
        
        leftImageView = UIImageView()
//        leftImageView.backgroundColor = .orange
        self.addSubview(leftImageView)
        leftImageView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(29/630*WIDTH)
            make.top.equalTo(self).offset(26/1134*HEIGHT)
            make.size.equalTo(118/1134*HEIGHT)
        }
        titleLabel = UILabel()
//        titleLabel.layer.borderWidth = 0.5
//        titleLabel.layer.borderColor = UIColor.gray.cgColor
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
        make.left.equalTo(leftImageView.snp.right).offset(15/636*WIDTH)
            make.top.equalTo(leftImageView).offset(3/1134*HEIGHT)
            make.width.equalTo(LabelWidth)
            make.height.equalTo(39/1134*HEIGHT)
        }
        
        detailLabel = UILabel()
//        detailLabel.layer.borderWidth = 0.5
//        detailLabel.layer.borderColor = UIColor.gray.cgColor
        detailLabel.font = thirdFont
        detailLabel.textColor = .lightGray
        detailLabel.numberOfLines = 3
        self.addSubview(detailLabel)
        detailLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel)
        make.top.equalTo(titleLabel.snp.bottom).offset(3/1134*HEIGHT)
            make.width.equalTo(LabelWidth)
            make.height.equalTo(67/1134*HEIGHT)
        }
        
    }
    func upDataWithArray(imageURL:Array<Any>,title:Array<Any>,subtitle:Array<Any>,index:IndexPath) -> (){
        var imageArr:Array! = imageURL[0] as?Array<String>
        var titleArr:Array! = title[0] as?Array<String>
        var subtitleArr:Array! = subtitle[0] as?Array<String>
        
        leftImageView.image = UIImage(named: (imageArr[index.row]))
        
        titleLabel.text = titleArr[index.row]
        
        detailLabel.text = subtitleArr[index.row]
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
