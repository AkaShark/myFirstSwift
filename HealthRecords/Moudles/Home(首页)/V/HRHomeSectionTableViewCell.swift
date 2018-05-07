//
//  HRHomeSectionTableViewCell.swift
//  HealthRecords
//
//  Created by kys-20 on 2018/4/19.
//  Copyright © 2018年 kys-20. All rights reserved.
//

import UIKit

protocol homeTableViewCellClickDelegate {
    func clickTheMore()
}

class HRHomeSectionTableViewCell: UITableViewCell {
    var cellDelegate: homeTableViewCellClickDelegate?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpTheView(titleName: String,btnName: String,imageName: String) -> ()
    {
        let label = UILabel()
        label.text = titleName
        label.textColor = StandGray
        self.contentView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(29/637*WIDTH)
            make.top.equalTo(self).offset(20/1134*HEIGHT)
            make.height.equalTo(33/70*self.height)
            make.width.equalTo(125/637*WIDTH)
        }
        
        let btn = UIButton()
        btn.setTitle(btnName, for: .normal)
        btn.setTitleColor(StandGray, for: .normal)
        btn.addTarget(self, action: #selector(touchTheMoreBtn), for: .touchUpInside)
        self.contentView.addSubview(btn)
        btn.snp.makeConstraints { (make) in
            //            make.top.equalTo(self).offset(20/1134*HEIGHT)
            make.top.equalTo(label.snp.top).offset(0)
            make.left.equalTo(self).offset(504/637*WIDTH)
            make.width.equalTo(60/647*WIDTH)
            make.height.equalTo(30/1134*HEIGHT)
        }
        
        let imageBtn = UIButton()
        imageBtn.setImage(UIImage(named: imageName), for: .normal)
        imageBtn.addTarget(self, action: #selector(touchTheMoreBtn), for: .touchUpInside)
        self.contentView.addSubview(imageBtn)
        imageBtn.snp.makeConstraints { (make) in
            make.left.equalTo(btn.snp.right).offset(20/637*WIDTH)
            make.top.equalTo(btn.snp.top)
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        
    }
    @objc func touchTheMoreBtn()
    {
        self.cellDelegate?.clickTheMore()
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

