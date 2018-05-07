//
//  HRRegisterViewController.swift
//  HealthRecords
//
//  Created by kys-3 on 2018/4/11.
//  Copyright © 2018年 kys-20. All rights reserved.
//

import UIKit
import PKHUD

/// 优化这个C这个C里面包含了太多的内容（考虑写拓展）
class HRRegisterViewController: HRBaseViewController,HRLoginDelegate,HRRegisterDelegate {

    
    var txt :Int!
    
    
    override func viewWillAppear(_ animated: Bool) {
        //        显示导航栏
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        switch txt {
        case 100:
            let loginView = HRLoginView(frame:CGRect.init(x: 0, y: 0, width: WIDTH, height: HEIGHT))
            loginView.delegate = self
            self.changeNavTitle(navTitleName: "登录")
            
            self.view.addSubview(loginView)
            
        case 101:
            let registerView = HRRegisterView(frame:CGRect.init(x: 0, y: 0, width: WIDTH, height: HEIGHT))
            registerView.registerDelegate = self
            self.changeNavTitle(navTitleName: "注册")
            
            self.view.addSubview(registerView)
        default:
            break
        }
        
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    ///    获取验证码
    func getSomeSmsCode(phone: String)
    {
        //        判断是否电话号码符合要求
        if (Validate.phoneNum(phone).isRight)
        {
            BmobSMS.requestCodeInBackground(withPhoneNumber: phone, andTemplate: "smsCode") { (numebr, error) in
                if (error != nil)
                {
                    //                可以加动效比如隐藏显示之类的  考虑将验证码和密码输入框换位
                    HUD.flash(.label("获取验证码失败"), delay: 0.5) { _ in
                        //                        print("License Obtained.")
                    }
                }
                else
                {
                    //                hud 验证码获取失败
                   
//                    print("验证码获取失败,错误原因:\(String(describing: error))")
                }
            }
        }
        else
        {
            //            hud 电话号码有错误
            HUD.flash(.label("电话号码错误"), delay: 0.5) { _ in
//                print("License Obtained.")
            }
//            print("输入的手机号有问题")
        }
    }
    
    
    
    //    MARK:- 代理方法实现
    func logInBtnClick(userName: String, password: String, button: DKTransitionButton)
    {
        
        //        对应用户名和密码的判断
        BmobUser.loginWithUsername(inBackground: userName, password: password)
        { (user, error) in
            //            进行登录提示框
            
            if user != nil
            {
                // 成功，进行界面切换
                button.startSwitchAnimation(1, completion: { () -> () in
                    //处理根视图的变化
                    let myAppdelegate = UIApplication.shared.delegate as! AppDelegate
                    myAppdelegate.logInChangeTheRootVC()
                    
                })
            }
            else
            {
                //                HUD 用户信息错误
                button.startShakeAnimation(1, completion: {
                    HUD.flash(.label("账号或密码错误"), delay: 0.5) { _ in
                        print("License Obtained.")
                    }
                })
            }
            
        }
        
    }
    
    //    获取验证码
    func noteBtnClick(phone: String)
    {
        self.getSomeSmsCode(phone: phone)
    }
    
    //    点击完成的方法
    func registerUer(userName: String, password: String, smsCode: String) {
        
        //        判断输入的各项信息是否有错误
        if (userName.isEmpty||password.count<6||smsCode.isEmpty)
        {
            //            hud提示
            HUD.flash(.label("输入信息不符合规则"), delay: 0.5) { _ in
                print("License Obtained.")
            }
//            print("输入信息不符合规则")
        }
        else
        {
            BmobUser.signOrLoginInbackground(withMobilePhoneNumber: userName, smsCode: smsCode, andPassword: password) { (user, error) in
                if (error != nil)
                {
                    HUD.show(.error)
                    HUD.hide(afterDelay: 0.5)
                }
                else
                {
                    HUD.flash(.success, delay: 0.5)
                    //               hud 注册成功 跳转到系统 切换根视图
                    let myappDelegate = UIApplication.shared.delegate as! AppDelegate
                    myappDelegate.logInChangeTheRootVC()
                    //                登陆失败 HUD
//                    print("登陆失败:\(String(describing: error))")
                }
            }
        }
    }
    
    /// 忘记密码重置密码(获取验证码)
    func getSmsCode(phone: String)
    {
        self.getSomeSmsCode(phone: phone)
    }
    
//    忘记密码 成功修改密码然后加动画
    func forgetPassword(smsCode: String, newPassword: String, button: DKTransitionButton)
    {
        BmobUser.resetPasswordInbackground(withSMSCode: smsCode, andNewPassword: newPassword) { (isSuccessful, error) in
            if isSuccessful
            {
//
                HUD.flash(.label("修改成功请重新登陆"), delay: 0.5) { _ in
                    print("License Obtained.")
                }
            }
            else
            {
                HUD.show(.error)
                HUD.hide(afterDelay: 0.5)
//                print("重置密码失败\(String(describing: error))")
            }
        }
    }
    
    
    
}

