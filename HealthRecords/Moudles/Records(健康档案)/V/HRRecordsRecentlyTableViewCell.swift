//
//  HRRecordsRecentlyTableViewCell.swift
//  HealthRecords
//
//  Created by kys-20 on 2018/4/21.
//  Copyright © 2018年 kys-20. All rights reserved.
//

import UIKit

class HRRecordsRecentlyTableViewCell: UITableViewCell {
    
    let timeLable = UILabel()
    let hospitalLabel = UILabel()
    let speciesLabel = UILabel()
    let seccoLable = UILabel()
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) 
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUpUI(timeText: String,hospitalTitle: String,speciesTitle: String) -> ()
    {
        
        timeLable.textColor = .black
        timeLable.text = timeText
        self.addSubview(timeLable)
        timeLable.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(29/637*WIDTH)
            make.top.equalTo(self).offset(20/1134*HEIGHT)
            make.height.equalTo(33/70*self.height)
            make.width.equalTo(550/640*WIDTH)
        }
        
        
        hospitalLabel.textColor = .black
        hospitalLabel.text = hospitalTitle
        self.addSubview(hospitalLabel)
        hospitalLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(245/1134*WIDTH)
            make.top.equalTo(timeLable)
            make.width.equalTo(520/1134*WIDTH)
            make.height.equalTo(33/70*self.height)
        }
        
        
        speciesLabel.textColor = .black
        speciesLabel.text = speciesTitle
        self.addSubview(speciesLabel)
        speciesLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(504/637*WIDTH)
            make.top.equalTo(timeLable)
            make.width.equalTo(248/1134*WIDTH)
            make.height.equalTo(33/70*self.height)
        }
        
        
        seccoLable.textColor = .black
        seccoLable.text = speciesTitle
        self.addSubview(seccoLable)
        seccoLable.snp.makeConstraints({ (make) in
            make.left.equalTo(self.hospitalLabel.snp.right).offset(20)
            make.top.equalTo(self.hospitalLabel.snp.top)
            make.width.equalTo(520/1134*WIDTH)
            make.height.equalTo(33/70*70/1136*HEIGHT)
        })
        
    }
    
    
    
}

