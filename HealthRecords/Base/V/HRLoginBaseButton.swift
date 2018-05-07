//
//  HRLoginBaseButton.swift
//  HealthRecords
//
//  Created by kys-20 on 2018/4/10.
//  Copyright © 2018年 kys-20. All rights reserved.
//


import UIKit

/// 基类button
class HRLoginBaseButton: UIButton
{

    /// 背景颜色 想要更改的话直接更改这个属性
    var backColor = MainColor
    /// 按住时背景颜色
    var touchDownBackGroundColor = UIColor.white
    /// 按住时标题的颜色
    var touchDownTitleColor = MainColor
    
   
    /// 重写的构造方法登陆注册界面用的
    ///
    /// - Parameters:
    ///   - frame: 大小 主要x,y
    ///   - btnTitle: button的标题
    ///   - btnColor: button的背景颜色
    ///   - titleColor: button文字的颜色
    ///   - isSelected: 是否按住变色（看情况）
    init(frame: CGRect,btnTitle: String,btnColor: UIColor,titleColor: UIColor,isSelected: Bool)
    {
        super.init(frame: frame)
        self.setTheButton(btnTitle: btnTitle, btnColor: btnColor,titleColor: titleColor,isSelected: isSelected)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /// 外部改变这个button的成员变量后调用这个方法生效
    func changeBtnSomeConfig() {
        self.backgroundColor = backColor
//        self.setBackgroundImage(UIColor.createImage(color: touchDownBackGroundColor, size: self.frame.size), for: .highlighted)
        self.setTitleColor(touchDownTitleColor, for: .highlighted)
    }
    
//    设置button（私有方法）
    private func setTheButton(btnTitle: String,btnColor: UIColor,titleColor: UIColor,isSelected: Bool) -> ()
    {
        if isSelected
        {
            //颜色的拓展方法
            self.setBackgroundImage(UIColor.createImage(color: touchDownBackGroundColor, size: self.frame.size), for: .highlighted)
            self.setTitleColor(touchDownTitleColor, for: .highlighted)
        }
        self.backgroundColor = backColor
        self.setTitleColor(titleColor, for: .normal)
        self.setTitle(btnTitle, for: .normal)
        self.layer.cornerRadius = 20
        self.layer.borderColor = btnColor.cgColor
        self.layer.borderWidth = 1
//        切割
        self.layer.masksToBounds = true
    }
    
    

}
