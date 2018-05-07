//
//  HRRecordsHeadView.swift
//  HealthRecords
//
//  Created by kys-20 on 2018/4/20.
//  Copyright © 2018年 kys-20. All rights reserved.
//

import UIKit


protocol tureToTheRecordDelegate {
    func toTheRecord(btnTitle: String,index: Int)
    func selectedTheFamilyMembers()
}

class HRRecordsHeadView: UIView {
    
    var btn:HRHomeBtn?
    var delegate: tureToTheRecordDelegate?
    
    init(frame:CGRect,userImage: String,userName: String,titleName: NSArray,imageName: NSArray)
    {
        super.init(frame:frame)
        setUpUI(userImage: userImage, userName: userName, titleName: titleName, imageName: imageName)
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpUI(userImage:String,userName: String,titleName:NSArray,imageName: NSArray) -> ()
    {
        self.backgroundColor = MainColor
        let headImageView = UIImageView()
        headImageView.image = UIImage(named: "头像 女孩1")
        
        headImageView.layer.cornerRadius = 45
        headImageView.layer.masksToBounds = true
        self.addSubview(headImageView)
        headImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(165/2205*HEIGHT)
            
            make.centerX.equalTo(self.snp.centerX)
            make.width.height.equalTo(90)
        }
        
        let nameLabel = UILabel()
        
        nameLabel.textColor = .white
        nameLabel.text = userName
        nameLabel.font = mainFont
        nameLabel.textAlignment = .center
        self.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self)
            make.top.equalTo(self).offset(470/2205*HEIGHT)
            make.width.equalTo(WIDTH)
            make.height.equalTo(70/2205*HEIGHT)
        }
        
        let titleLable = UILabel()
        
        titleLable.textColor = .white
        titleLable.font = thirdFont
        titleLable.text = "完善健康信息，让我们更懂你"
        titleLable.textAlignment = .center
        self.addSubview(titleLable)
        titleLable.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(0)
            make.top.equalTo(self).offset(563/2205*HEIGHT)
            make.width.equalTo(WIDTH)
            make.height.equalTo(40/2205*HEIGHT)
        }
        self.addButton(button: self.generateButtonWithStyle(style: .upTitleDownImage, imageName: "", titleName: "切换就诊人"), frame: CGRect())
        
        let height = 232/2205*HEIGHT
        let weight = WIDTH/3
        
        for i in 0..<imageName.count
        {
            let row = i / 3
            let col = i % 3
            let picX = 0 + weight * CGFloat(col)
            let picY = 639/2205*HEIGHT + height * CGFloat(row)
//            let btn = HRHomeBtn(frame: CGRect(x: picX, y: picY, width: weight, height: height), imageName: imageName as! Array<String>, titleName: titleName as! Array<String>)
            let btn = HRHomeBtn(frame: CGRect(x: picX, y: picY, width: weight, height: height), imageName: imageName as! Array<String>, titleName: titleName as! Array<String>, i: i)
            btn.backgroundColor = .white
            for button in btn.subviews
            {
                if button is JXLayoutButton
                {
                    let jxButton = button as! JXLayoutButton
                    jxButton.tag = i
                    jxButton.addTarget(self, action: #selector(touchTheBtnToRecord(_:)), for: .touchUpInside)
                }
            }
            self.addSubview(btn)
        }
    }
    
    /// 添加btn
    private func addButton(button:JXLayoutButton,frame:CGRect) -> ()
    {
        button.addTarget(self, action: #selector(selectedTheFamilyMembers), for: .touchUpInside)
        self.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.top.equalTo(90/2205*HEIGHT)
            make.left.equalTo(self).offset(965/1235*WIDTH)
            make.width.equalTo(212/1235*WIDTH)
            make.height.equalTo(90/2205*HEIGHT)
        }
    }
    
    private func generateButtonWithStyle(style: JXLayoutButtonStyle,imageName: String,titleName: String) -> JXLayoutButton
    {
        let button = JXLayoutButton()
        button.backgroundColor = .clear
        button.setImage(UIImage(named: imageName), for: .normal)
        button.setTitle(titleName, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layoutStyle = style
        return button
    }
    
    @objc func touchTheBtnToRecord(_ button:JXLayoutButton) -> ()
    {
        self.delegate?.toTheRecord(btnTitle: (button.titleLabel?.text)!, index: button.tag)
    }
    
//    切换就诊人
    @objc func selectedTheFamilyMembers()
    {
        self.delegate?.selectedTheFamilyMembers()
    }
    
    
}

