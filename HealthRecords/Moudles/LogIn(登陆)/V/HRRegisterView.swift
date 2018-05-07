//
//  HRRegisterView.swift
//  HealthRecords
//
//  Created by kys-3 on 2018/4/11.
//  Copyright © 2018年 kys-20. All rights reserved.
//

import UIKit
import SnapKit


protocol HRRegisterDelegate {
    func registerUer(userName: String,password: String,smsCode: String)
    func noteBtnClick(phone: String)
}

class HRRegisterView: UIView,UITextFieldDelegate{

    
    var registerDelegate: HRRegisterDelegate?
    
    var imageUser : UIImageView!
    var imagePwd : UIImageView!
    var imageNote : UIImageView!
    var txtUser : UITextField!
    var txtPwd : UITextField!
    var txtNote : UITextField!
    var bottomLinesUser : UIView!
    var bottomLinesPwd : UIView!
    var bottomLinesNote : UIView!
    var noteBtn : UIButton!
    var eyeBtn : UIButton!
    var registerBtn : HRLoginBaseButton!
 
    
    var countdownTimer: Timer?
    
    var remainingSeconds: Int = 0 {
        willSet {
            
            noteBtn.setTitle("\(newValue)秒", for: .normal)
            
            if newValue <= 0 {
                noteBtn.setTitle("重新获取", for: .normal)
                isCounting = false
            }
        }
    }
    
    var isCounting = false {
        willSet {
            if newValue {
                countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime(_:)), userInfo: nil, repeats: true)
                
                remainingSeconds = 60
                
            } else {
                countdownTimer?.invalidate()
                countdownTimer = nil

            }
            
            noteBtn.isEnabled = !newValue
        }
    }


    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
        
    self.addGestureRecognizer(UITapGestureRecognizer(target:self,action:#selector(handleTap(sender:))))

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() -> () {
       
        
        self.backgroundColor = MainBackGroundColor
        
        imageUser = UIImageView()
        
        imageUser.image = UIImage(named:"手机.png")
        
        self.addSubview(imageUser)
        
        imageUser.snp.makeConstraints({(make) in make.left.equalTo(self).offset(56/701*WIDTH)
            make.top.equalTo(self).offset(240/1256*HEIGHT)
            make.size.equalTo(30)})
        
        txtUser = UITextField()
        
        txtUser.delegate = self
        txtUser.tag = 100
       
        
        txtUser.placeholder = "请输入手机号"
        
        txtUser.clearButtonMode = .whileEditing
        
        txtUser.keyboardType = .numberPad
        
        //使文本框在界面打开时就获取焦点，并弹出输入键盘
        txtUser.becomeFirstResponder()
        
//        //使文本框失去焦点，并收回键盘
//        txtUser.resignFirstResponder()
        
        txtUser.borderStyle = UITextBorderStyle.none
        
        txtUser.layer.borderColor = MainColor.cgColor
        
        self.addSubview(txtUser)
        
        txtUser.snp.makeConstraints({(make) in
            make.left.equalTo(imageUser).offset(35)
            make.top.equalTo(imageUser.snp.top).offset(-7)
            make.width.equalTo(self).offset(-100)
            make.height.equalTo(50)
        })
        
        bottomLinesUser = UIView()
        
        bottomLinesUser.backgroundColor = MainColor
        
        self.addSubview(bottomLinesUser)
        
        bottomLinesUser.snp.makeConstraints({(make) in make.left.equalTo(imageUser).offset(-5)
            make.top.equalTo(imageUser.snp.bottom).offset(8)
        make.width.equalTo(txtUser.snp.width).offset(40)
            make.height.equalTo(1)
        })
        
        imagePwd = UIImageView()
        
        imagePwd.image = UIImage(named:"账号密码.png")
        
        self.addSubview(imagePwd)
        
        imagePwd.snp.makeConstraints({(make) in make.left.equalTo(imageUser)
            make.top.equalTo(imageUser.snp.bottom).offset(30)
            make.size.equalTo(30)
        })
        
        txtPwd = UITextField()
        
        txtPwd.delegate = self
        txtPwd.tag = 101

        
        txtPwd.isSecureTextEntry = true
        
        txtPwd.clearButtonMode = .whileEditing
        
        txtPwd.placeholder = "设置登录密码，不少于6位"
        
        txtPwd.keyboardType = .default
        
        txtPwd.becomeFirstResponder()
        
        txtPwd.resignFirstResponder()
        
        txtPwd.borderStyle = .none
        
        self.addSubview(txtPwd)
        
        txtPwd.snp.makeConstraints({(make) in make.left.equalTo(txtUser)
            make.top.equalTo(imagePwd.snp.top).offset(-7)
            make.width.equalTo(txtUser).offset(-30)
            make.height.equalTo(txtUser)
            
        })
        
        bottomLinesPwd = UIView()
        
        bottomLinesPwd.backgroundColor = .lightGray
        
        self.addSubview(bottomLinesPwd)
        
        bottomLinesPwd.snp.makeConstraints({(make) in make.left.equalTo(imagePwd).offset(-5)
            make.top.equalTo(imagePwd.snp.bottom).offset(8)
            make.width.equalTo(bottomLinesUser)
            make.height.equalTo(1)
        })
        
        eyeBtn = UIButton()
        
        eyeBtn.setImage(UIImage(named:"眼睛-闭"), for: .normal)
        
        eyeBtn.addTarget(self, action: #selector(eyeBtnClick(sender:)), for: .touchUpInside)
        
        self.addSubview(eyeBtn)
        
        eyeBtn.snp.makeConstraints { (make) in
            make.left.equalTo(txtPwd.snp.right)
            make.top.equalTo(txtPwd.snp.top).offset(15)
            make.size.equalTo(20)
        }

        
        imageNote = UIImageView()
        
        imageNote.image = UIImage(named:"钥匙.png")
        
        self.addSubview(imageNote)
        
        imageNote.snp.makeConstraints { (make) in
            make.left.equalTo(imageUser)
            make.top.equalTo(imagePwd.snp.bottom).offset(30)
            make.size.equalTo(imagePwd)
        }
        
        txtNote = UITextField()
        
        txtNote.delegate = self
        
        txtNote.tag = 102
        
        txtNote.placeholder = "请输入验证码"
        
        self.addSubview(txtNote)
        
        txtNote.snp.makeConstraints { (make) in
        make.left.equalTo(imageNote.snp.right).offset(5)
            make.top.equalTo(imageNote.snp.top).offset(-8)
            make.width.height.equalTo(txtUser)
            
        }
        
        bottomLinesNote = UIView()
        
        bottomLinesNote.backgroundColor = .lightGray
        
        self.addSubview(bottomLinesNote) 
        
        bottomLinesNote.snp.makeConstraints { (make) in
            make.left.equalTo(imageNote).offset(-5)
            make.top.equalTo(imageNote.snp.bottom).offset(8)
            make.width.equalTo(bottomLinesUser)
            make.height.equalTo(1)
        }
        
        noteBtn = UIButton()
        
        noteBtn.setTitle("获取验证码", for: .normal)
        
        noteBtn.setTitleColor(.white, for: .normal)
        
        noteBtn.backgroundColor = .orange
        
        noteBtn.layer.borderWidth = 1.0
        
        noteBtn.layer.borderColor = UIColor.orange.cgColor
        
        noteBtn.layer.cornerRadius = 18
        
        noteBtn.addTarget(self, action: #selector(smsClick), for: .touchUpInside)
        
        self.addSubview(noteBtn)
        
        noteBtn.snp.makeConstraints { (make) in
            make.left.equalTo(txtNote.snp.right).offset(-130)
            make.top.equalTo(txtNote).offset(1)
            make.width.equalTo(120)
            make.height.equalTo(40)
        }
        
        registerBtn = HRLoginBaseButton(frame:CGRect.init(x: 60/701*WIDTH, y: 590/1256*HEIGHT, width: LoginBtnW, height: LoginBtnH),btnTitle:"完成",btnColor:MainColor,titleColor:.white,isSelected:false)
        registerBtn.addTarget(self, action: #selector(finshClick), for: .touchUpInside)
        
        self.addSubview(registerBtn)
        
    }
    //点击空白view键盘收回
    @objc func handleTap(sender: UITapGestureRecognizer)
    {
        if sender.state == .ended{
            txtUser.resignFirstResponder()
            txtPwd.resignFirstResponder()
            txtNote.resignFirstResponder()
        }
        bottomLinesUser.backgroundColor = .lightGray
        bottomLinesPwd.backgroundColor = .lightGray
        bottomLinesNote.backgroundColor = .lightGray
        sender.cancelsTouchesInView = false
        
    }
    
    //设置密码可见与否
    @objc func eyeBtnClick(sender: UIButton){
        if sender.isSelected{
            eyeBtn.setImage(UIImage(named:"眼睛-闭"), for: .normal)
            txtPwd.isSecureTextEntry = true
        }
        else{
            eyeBtn.setImage(UIImage(named:"眼睛-睁"), for: .normal)
            txtPwd.isSecureTextEntry = false
        }
        sender.isSelected = !sender.isSelected
    }
    
    //点击textfield下划线颜色改变
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.tag == 100{
            bottomLinesUser.backgroundColor = MainColor
            bottomLinesPwd.backgroundColor = .lightGray
            bottomLinesNote.backgroundColor = .lightGray
        }
        else if textField.tag == 101{
            bottomLinesUser.backgroundColor = .lightGray
            bottomLinesPwd.backgroundColor = MainColor
            bottomLinesNote.backgroundColor = .lightGray
        }
        else if textField.tag == 102 {
            bottomLinesUser.backgroundColor = .lightGray
            bottomLinesPwd.backgroundColor = .lightGray
            bottomLinesNote.backgroundColor = MainColor
            
        }
    }

    /// 点击获取验证码
    @objc func smsClick()
    {
//        传值
        self.registerDelegate?.noteBtnClick(phone: txtUser.text!)

        isCounting = true
}
    
    /// 点击完成 （注册）
    @objc func finshClick() -> ()
    {
        self.registerDelegate?.registerUer(userName: txtUser.text!, password: txtPwd.text!, smsCode: txtNote.text!)
    }

    
    @objc func updateTime(_ timer: Timer) {
        remainingSeconds -= 1
    }

}

