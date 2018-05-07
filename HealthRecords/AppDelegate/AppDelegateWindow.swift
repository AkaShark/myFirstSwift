//
//  AppDelegateWindow.swift
//  HealthRecords
//
//  Created by kys-20 on 2018/4/14.
//  Copyright © 2018年 kys-20. All rights reserved.
//

import Foundation
import IQKeyboardManagerSwift
extension AppDelegate
{
     func setUpTheWindowConfig() -> ()
    {
        self.window?.backgroundColor = UIColor.white
        let nav = HRBaseNavigationController(rootViewController: HRLoginViewController())
        let maneger = IQKeyboardManager.sharedManager()
        maneger.enable = true
        maneger.shouldResignOnTouchOutside = true
        window?.rootViewController = nav
        window?.frame = UIScreen.main.bounds
        window?.makeKeyAndVisible()
        
        
        let launch = LaunchIntroductionView.shared(withImages: ["智能识别","就医记录","家人管理"], andWant: false)
//        launch?.backgroundColor = .red
        launch?.currentColor = MainColor
        launch?.nomalColor = UIColor.white
        
    }
    func logInChangeTheRootVC() -> ()
    {
        let maneger = IQKeyboardManager.sharedManager()
        maneger.enable = true
        maneger.shouldResignOnTouchOutside = true
        let root = HRBaseTabBarController()
        window?.rootViewController = root
        self.window?.backgroundColor = UIColor.white
        window?.makeKeyAndVisible()
        window?.frame = UIScreen.main.bounds
    }
}

