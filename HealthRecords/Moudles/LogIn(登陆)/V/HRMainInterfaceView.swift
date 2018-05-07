//
//  HRMainInterfaceView.swift
//  HealthRecords
//
//  Created by kys-3 on 2018/4/11.
//  Copyright © 2018年 kys-20. All rights reserved.
//

import UIKit
import SnapKit

protocol touchTheThirdLogIn
{
    func touchTheThirdLogin(index:Int)
}

class HRMainInterfaceView: UIView {

    var touchDelegate: touchTheThirdLogIn?
    
    var imageIcon : UIImageView!
    var loginBtn : HRLoginBaseButton!
    var registerBtn : HRLoginBaseButton!
    var weixinBtn: UIButton?
    var qqBtn: UIButton?
    var xinlang: UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() -> () {
        imageIcon = UIImageView()
        imageIcon.image = UIImage(named: "背景1")
        self.addSubview(imageIcon)
        
        
        imageIcon.snp.makeConstraints { (make) in
            make.left.equalTo(self)
            make.top.equalTo(self)
            make.width.equalTo(self)
            make.height.equalTo(self)
            
        }
            
        loginBtn = HRLoginBaseButton(frame: CGRect.init(x: 38, y: 300, width: LoginBtnW, height: LoginBtnH), btnTitle: "登录", btnColor: MainColor, titleColor: .white, isSelected: true)
            
        self.addSubview(loginBtn)
            
        registerBtn = HRLoginBaseButton(frame: CGRect.init(x: 38, y: 370, width: LoginBtnW, height: LoginBtnH), btnTitle: "注册", btnColor:MainColor ,titleColor: .white, isSelected: true)
        self.addSubview(registerBtn)
        
        let view1 = UIView()
        view1.backgroundColor = MainColor
        self.addSubview(view1)
        view1.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(87/638*WIDTH)
            make.top.equalTo(self).offset(884/1134*HEIGHT)
            make.width.equalTo(100)
            make.height.equalTo(1)
        }
        
        let view2 = UIView()
        view2.backgroundColor = MainColor
        self.addSubview(view2)
        view2.snp.makeConstraints { (make) in
            make.left.equalTo(view1.snp.right).offset(100)
            make.top.equalTo(view1.snp.top)
            make.width.equalTo(100)
            make.height.equalTo(1)
        }
        
        let tileLable = UILabel()
        tileLable.textColor = MainColor
        tileLable.font = thirdFont
        tileLable.text = "第三方登录"
        tileLable.textAlignment  = .center
        self.addSubview(tileLable)
        tileLable.snp.makeConstraints { (make) in
            make.left.equalTo(view1.snp.right).offset(16)
            make.centerY.equalTo(view2.snp.centerY)
            make.width.equalTo(69)
            make.height.equalTo(30)
        }
        
        xinlang = UIButton()
        xinlang?.setBackgroundImage(UIImage(named: "sina_96px_1176836_easyicon.net"), for: .normal)
        xinlang?.layer.cornerRadius = 20
        xinlang?.tag = 0
        xinlang?.addTarget(self, action: #selector(touchTheXinlang(_:)), for:.touchUpInside)
        self.addSubview(xinlang!)
        xinlang?.snp.makeConstraints({ (make) in
            make.left.equalTo(view1.snp.left)
            make.top.equalTo(view1.snp.bottom).offset(40)
            make.width.equalTo(40)
            make.height.equalTo(40)
        })
        
        qqBtn = UIButton()
        qqBtn?.layer.cornerRadius = 20
        qqBtn?.setBackgroundImage(UIImage(named: "social-qq-2"), for: .normal)
        qqBtn?.tag = 1
        self.addSubview(qqBtn!)
        qqBtn?.snp.makeConstraints({ (make) in
            make.left.equalTo((xinlang?.snp.right)!).offset(92)
            make.top.equalTo(xinlang!)
            make.width.equalTo(40)
            make.height.equalTo(40)
        })
        
        weixinBtn = UIButton()
        weixinBtn?.layer.cornerRadius = 20
        weixinBtn?.tag = 2
        weixinBtn?.setBackgroundImage(UIImage(named: "微信-3"), for: .normal)
        self.addSubview(weixinBtn!)
        weixinBtn?.snp.makeConstraints({ (make) in
            make.left.equalTo((qqBtn?.snp.right)!).offset(92)
            make.top.equalTo(xinlang!)
            make.width.equalTo(40)
            make.height.equalTo(40)
        })
    }
    
    //        点击新浪
    @objc func touchTheXinlang(_ btn : UIButton)
    {
        
        self.touchDelegate?.touchTheThirdLogin(index: btn.tag)
    
    }

    
}
    


