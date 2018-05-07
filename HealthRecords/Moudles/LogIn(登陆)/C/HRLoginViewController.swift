//
//  HRLoginViewController.swift
//  HealthRecords
//
//  Created by kys-3 on 2018/4/11.
//  Copyright © 2018年 kys-20. All rights reserved.
//

import UIKit

class HRLoginViewController: HRBaseViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
//        隐藏导航栏
        self.navigationController?.navigationBar.isHidden = true
//        self.changeNavTitle(navTitleName: "主页面")
        let mainInterface = HRMainInterfaceView(frame:CGRect.init(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height))
        mainInterface.touchDelegate = self
        self.view.addSubview(mainInterface)
        
        mainInterface.loginBtn.tag = 100
        
        mainInterface.registerBtn.tag = 101
        
        mainInterface.loginBtn.addTarget(self, action: #selector(self.buttonClick(sender:)), for: .touchUpInside)

        mainInterface.registerBtn.addTarget(self, action: #selector(self.buttonClick(sender:)), for: .touchUpInside)
    }
    
    @objc func buttonClick(sender:HRLoginBaseButton){
        switch sender.tag {
        case 100:
            
            let loginView = HRRegisterViewController()
            loginView.txt = 100
        self.navigationController!.pushViewController(loginView, animated: true)
            
        case 101:
            
            let registerView = HRRegisterViewController()
            registerView.txt = 101
        self.navigationController!.pushViewController(registerView, animated: true)
            
        default:
            break
        }
        
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
   
}




