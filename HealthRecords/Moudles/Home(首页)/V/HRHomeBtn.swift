//
//  HRHomeBtn.swift
//  HealthRecords
//
//  Created by kys-20 on 2018/4/17.
//  Copyright © 2018年 kys-20. All rights reserved.
//

import UIKit

/// home的btn
class HRHomeBtn: UIView
{
    
    
    init(frame:CGRect,imageName:Array<String>,titleName:Array<String>,i:Int)
    {
        super.init(frame:frame)
        setUpUI(frame: frame, imageName: imageName, titleName: titleName,i: i)
    }
    
    func setUpUI(frame:CGRect,imageName:Array<String>,titleName:Array<String>,i:Int) ->()
    {
        self.backgroundColor = .white
//        self.layer.cornerRadius = WIDTH/10
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor(red: 244/255.0, green: 244/255.0, blue: 244/255.0, alpha: 1).cgColor
        
        self.addButton(button: generateButtonWithStyle(style: JXLayoutButtonStyle.upImageDownTitle, imageName: imageName[i], titleName: titleName[i]), frame:frame)
    }
   
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 添加btn
    private func addButton(button:JXLayoutButton,frame:CGRect) -> ()
    {
        
        self.addSubview(button)
        button.imageSize = CGSize(width: 40, height: 40)
        button.snp.makeConstraints { (make) in
            make.center.equalTo(self)
//            make.width.equalTo(self.width)
            make.size.equalTo(self.size)
        }
    }
    
    private func generateButtonWithStyle(style: JXLayoutButtonStyle,imageName: String,titleName: String) -> JXLayoutButton
    {
        let button = JXLayoutButton()
        button.setImage(UIImage(named: imageName), for: .normal)
        button.setTitle(titleName, for: .normal)
        button.setTitleColor(MainColor, for: .normal)
        button.layoutStyle = style
        return button
    }
    
   
    

}
