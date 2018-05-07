//
//  HRLoginView.swift
//  HealthRecords
//
//  Created by kys-3 on 2018/4/11.
//  Copyright © 2018年 kys-20. All rights reserved.
//

import UIKit
import SnapKit

protocol HRLoginDelegate {
    func logInBtnClick(userName: String, password: String,button:DKTransitionButton)
    func getSmsCode(phone:String)
    func forgetPassword(smsCode: String, newPassword: String,button:DKTransitionButton)
}


class HRLoginView: UIView,UITextFieldDelegate
{
    
    
    /// 声明代理
    var delegate: HRLoginDelegate?
    
    var imageUser : UIImageView!
    var imagePwd : UIImageView!
    var txtUser : UITextField!
    var txtPwd : UITextField!
    var bottomLinesUser : UIView!
    var bottomLinesPwd : UIView!
    var loginBtn:DKTransitionButton!
    var forgetBtn : UIButton!
    //    声明忘记密码
    var txtSMS: UITextField?
    var imageNote: UIImageView?
    var smsLine: UIView?
    var isMiss: Bool = true
    var noteBtn : UIButton!
    
    var countdownTimer : Timer?
    
    var remainingSeconds :Int = 0{
        willSet{//在remainingSeconds的值将要变化时调用，并把值传给newValue
            noteBtn.setTitle("\(newValue)秒", for: .normal)
            
            if  newValue <= 0 {
                noteBtn.setTitle("重新获取", for: .normal)
                
            }
        }
    }
    
    var isCounting = false {
        willSet{
            if newValue{
                countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime(_time:)), userInfo: nil, repeats: true)
                
                remainingSeconds = 60
                
            }else{
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
        
        txtUser.borderStyle = UITextBorderStyle.none
        
        txtUser.layer.borderColor = MainColor.cgColor

        self.addSubview(txtUser)
        
        txtUser.snp.makeConstraints({(make) in make.left.equalTo(imageUser).offset(35)
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
        
        txtPwd.placeholder = "请输入密码"
        
        txtPwd.keyboardType = .default
        
        txtPwd.borderStyle = .none

        self.addSubview(txtPwd)
        
        txtPwd.snp.makeConstraints({(make) in make.left.equalTo(txtUser)
            make.top.equalTo(imagePwd.snp.top).offset(-7)
            make.width.equalTo(txtUser).offset(-90)
            make.height.equalTo(txtUser)
            
        })
        
        bottomLinesPwd = UIView()
        
        bottomLinesPwd.backgroundColor = .lightGray
        
        self.addSubview(bottomLinesPwd)
        
        bottomLinesPwd.snp.makeConstraints({(make) in
            make.left.equalTo(imagePwd).offset(-5)
            make.top.equalTo(imagePwd.snp.bottom).offset(8)
            make.width.equalTo(bottomLinesUser)
            make.height.equalTo(1)
        })
        
        
        forgetBtn = UIButton()
        
        forgetBtn.setTitle("忘记密码?", for: .normal)
        
        forgetBtn.setTitleColor(StandGray, for: .normal)
        
        forgetBtn.addTarget(self, action: #selector(forgetBtnClick), for: .touchUpInside)
        self.addSubview(forgetBtn)
        
        forgetBtn.snp.makeConstraints({(make) in make.left.equalTo(txtPwd.snp.right)
            make.top.equalTo(txtPwd)
            make.width.equalTo(90)
            make.height.equalTo(txtPwd)
        })
        
        
        
        //        隐藏的忘记密码
        
        imageNote = UIImageView()
        imageNote?.image = UIImage(named:"钥匙")
        imageNote?.isHidden = true
        
        self.addSubview(imageNote!)
        
        imageNote?.snp.makeConstraints({(make) in
            make.left.equalTo(imageUser)
            make.top.equalTo(imageUser.snp.bottom).offset(30)
            make.size.equalTo(30)
        })
        
        
        
        txtSMS = UITextField()
        
        txtSMS?.delegate = self
        
        txtSMS?.tag = 102
        
        txtSMS?.isSecureTextEntry = true
        
        txtSMS?.placeholder = "请输入验证码"
        
        txtSMS?.keyboardType = .default
        
        txtSMS?.borderStyle = .none
        
        txtSMS?.isHidden = true
        
        self.addSubview(txtSMS!)
        
        txtSMS?.snp.makeConstraints({(make) in make.left.equalTo(txtUser)
            make.top.equalTo((imageNote?.snp.top)!).offset(-7)
            make.width.equalTo(txtUser).offset(-90)
            make.height.equalTo(txtUser)
            
        })
        
        smsLine = UIView()
        
        smsLine?.backgroundColor = .lightGray
        smsLine?.isHidden = true
        
        self.addSubview(smsLine!)
        
        smsLine?.snp.makeConstraints({(make) in
            make.left.equalTo(imageNote!).offset(-5)
            make.top.equalTo(imageNote!.snp.bottom).offset(8)
            make.width.equalTo(bottomLinesUser)
            make.height.equalTo(1)
        })
        
        noteBtn = UIButton()
        
        noteBtn.setTitle("获取验证码", for: .normal)
        
        noteBtn.setTitleColor(.white, for: .normal)
        
        noteBtn.backgroundColor = .orange
        
        noteBtn.layer.borderWidth = 1.0
        
        noteBtn.layer.borderColor = UIColor.orange.cgColor
        
        noteBtn.layer.cornerRadius = 18
        
        noteBtn.addTarget(self, action: #selector(getSms), for: .touchUpInside)
        
        noteBtn.isHidden = true
        
        self.addSubview(noteBtn)
        
        noteBtn.snp.makeConstraints { (make) in
            make.left.equalTo(forgetBtn).offset(-30)
            make.top.equalTo(txtSMS!).offset(1)
            make.width.equalTo(120)
            make.height.equalTo(40)
        }
        

//        loginBtn = HRLoginBaseButton(frame:CGRect.init(x: 60/701*WIDTH, y: 510/1256*HEIGHT, width: LoginBtnW, height: LoginBtnH),btnTitle:"登录",btnColor:MainColor,titleColor:.white,isSelected:false)
//        loginBtn.addTarget(self, action: #selector(touchUpTheLoginBtn), for: .touchUpInside)
        loginBtn = DKTransitionButton(frame: CGRect(x: 60/701*WIDTH, y: 510/1256*HEIGHT, width: LoginBtnW, height: LoginBtnH))
        loginBtn.backgroundColor = MainColor
        loginBtn.setTitle("登录", for: UIControlState())
        loginBtn.addTarget(self, action: #selector(touchUpTheLoginBtn(_:)), for: UIControlEvents.touchUpInside)
        loginBtn.spiner.spinnerColor = .white
        self.addSubview(loginBtn)
        
        //        loginBtn.backgroundColor = UIColor(red: 208/255.0, green: 183/255.0, blue: 127/255.0, alpha: 1)
        
        
    }
    
    //点击空白view键盘收回
    @objc func handleTap(sender: UITapGestureRecognizer)
    {
        if sender.state == .ended{
            txtUser.resignFirstResponder()
            txtPwd.resignFirstResponder()
        }
        bottomLinesUser.backgroundColor = .lightGray
        bottomLinesPwd.backgroundColor = .lightGray
        
        sender.cancelsTouchesInView = false
    }
    
 
    //    获取验证码
    @objc func getSms()
    {
        self.delegate?.getSmsCode(phone: txtUser.text!)
        isCounting = true
    }
    //    点击忘记密码
    @objc func forgetBtnClick()
    {
        //        代码冗余 这个类的代码过多（后期修改）
        
        if isMiss
        {
            txtSMS?.isHidden = false
            smsLine?.isHidden = false
            imageNote?.isHidden = false
            noteBtn.isHidden = false
            
            //        开始动画
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationDuration(1)
            
            
            self.imagePwd.snp.updateConstraints { (make) in make.top.equalTo(self.imageUser.snp.bottom).offset(90)
                make.size.equalTo(30)
            }
            
            self.txtPwd.snp.updateConstraints({(make) in
                make.left.equalTo(self.txtUser)
                make.top.equalTo(self.imagePwd.snp.top).offset(-7)
                make.width.equalTo(self.txtUser).offset(-90)
                make.height.equalTo(self.txtUser)
                
            })
            
        self.bottomLinesPwd.snp.updateConstraints({(make) in
            make.left.equalTo(self.imagePwd).offset(-5)
        make.top.equalTo(self.imagePwd.snp.bottom).offset(8)
            make.width.equalTo(self.bottomLinesUser)
            make.height.equalTo(1)
            })
            
            loginBtn.isHidden = true

            forgetBtn.setTitle(" ", for: .normal)
            
        forgetBtn.setImage(UIImage(named:"收起箭头.png"), for: .normal)
            
            txtPwd.placeholder = "请输入新的密码"
            
//            loginBtn = HRLoginBaseButton(frame:CGRect.init(x: 60/701*WIDTH, y: 600/1256*HEIGHT, width: LoginBtnW, height: LoginBtnH),btnTitle:"修改并登录",btnColor:MainColor,titleColor:.white,isSelected:false)
            loginBtn = DKTransitionButton(frame: CGRect(x: 60/701*WIDTH, y: 600/1256*HEIGHT, width: LoginBtnW, height: LoginBtnH))
            loginBtn.backgroundColor = MainColor
            loginBtn.setTitle("修改并登录", for: UIControlState())
            loginBtn.addTarget(self, action: #selector(touchUpTheLoginBtn(_:)), for: UIControlEvents.touchUpInside)
            loginBtn.spiner.spinnerColor = .white
            self.addSubview(loginBtn)
            
            loginBtn.addTarget(self, action: #selector(touchUpTheLoginBtn(_:)), for: .touchUpInside)
            
            self.addSubview(loginBtn)
            self.imagePwd.layoutIfNeeded()
            self.txtPwd.layoutIfNeeded()
            self.bottomLinesPwd.layoutIfNeeded()
            UIView.commitAnimations()
            isMiss = false
            
        }
        else
        {
            isMiss = true
            txtSMS?.isHidden = true
            smsLine?.isHidden = true
            imageNote?.isHidden = true
            noteBtn.isHidden = true

            txtPwd.placeholder = "请输入密码"
            forgetBtn.setImage(nil, for: .normal)
            forgetBtn.setTitle("忘记密码?", for: .normal)
            
            loginBtn.setTitle("登录", for: .normal)
            loginBtn.frame = CGRect.init(x: 60/701*WIDTH, y: 510/1256*HEIGHT, width: LoginBtnW, height: LoginBtnH)
        
            loginBtn.addTarget(self, action: #selector(touchUpTheLoginBtn(_:)), for: .touchUpInside)
            
            //        开始动画
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationDuration(1)
            
            imagePwd.snp.updateConstraints({(make) in make.left.equalTo(imageUser)
                make.top.equalTo(imageUser.snp.bottom).offset(30)
                make.size.equalTo(30)
            })
            
            txtPwd.snp.updateConstraints({(make) in make.left.equalTo(txtUser)
                make.top.equalTo(imagePwd.snp.top).offset(-7)
                make.width.equalTo(txtUser).offset(-90)
                make.height.equalTo(txtUser)
                
            })
            bottomLinesPwd.snp.updateConstraints({(make) in
                make.left.equalTo(imagePwd).offset(-5)
                make.top.equalTo(imagePwd.snp.bottom).offset(8)
                make.width.equalTo(bottomLinesUser)
                make.height.equalTo(1)
            })
            
            self.imagePwd.layoutIfNeeded()
            self.txtPwd.layoutIfNeeded()
            self.bottomLinesPwd.layoutIfNeeded()
            UIView.commitAnimations()
            
        }
    }
    
    //点击textfield下划线颜色改变
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.tag == 100{
            bottomLinesUser.backgroundColor = MainColor
            bottomLinesPwd.backgroundColor = .lightGray
            smsLine?.backgroundColor = .lightGray
        }
        else if textField.tag == 101{
            bottomLinesUser.backgroundColor = .lightGray
            bottomLinesPwd.backgroundColor = MainColor
            smsLine?.backgroundColor = .lightGray
        }
        else if textField.tag == 102 {
            bottomLinesUser.backgroundColor = .lightGray
            bottomLinesPwd.backgroundColor = .lightGray
            smsLine?.backgroundColor = MainColor
            
        }
    }
    
    //    点击登陆按钮
    
    @objc func touchUpTheLoginBtn(_ button:DKTransitionButton) -> ()
    {
        loginBtn.startLoadingAnimation()
        
        if loginBtn.titleLabel?.text == "登录"
        {
           
            self.delegate?.logInBtnClick(userName:txtUser.text!, password: txtPwd.text!, button: button)
            
        }
        else
        {
            self.delegate?.forgetPassword(smsCode: (txtSMS?.text)!, newPassword: txtPwd.text!, button: button)
        }
        
    }
    
    //验证码记时事件
    @objc func updateTime(_time :Timer)
    {
        remainingSeconds -= 1
    }
    
    
}

