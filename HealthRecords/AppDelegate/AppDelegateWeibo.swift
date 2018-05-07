//
//  AppDelegateWeibo.swift
//  HealthRecords
//
//  Created by kys-20 on 2018/4/16.
//  Copyright © 2018年 kys-20. All rights reserved.
//

import Foundation

extension AppDelegate:WeiboSDKDelegate
{
    func didReceiveWeiboRequest(_ request: WBBaseRequest!) {
        
    }
    
    func didReceiveWeiboResponse(_ response: WBBaseResponse!) {
        guard let res = response as? WBAuthorizeResponse else { return  }
        
        guard let uid = res.userID else { return  }
        guard let accessToken = res.accessToken else { return }
        guard let  expirationDate = res.expirationDate else {return}
        let dic = ["access_token":accessToken,"uid":uid,"expirationDate":expirationDate] as [String : Any]
        
        BmobUser.loginInBackground(withAuthorDictionary: dic, platform: BmobSNSPlatformSinaWeibo) { (user, error) in
            if (error != nil)
            {
                print("weibo login error\(String(describing: error))")
            }
            else if (user != nil)
            {
                print(user?.objectId ?? String())
                self.logInChangeTheRootVC()
            }
        }

    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        let urlKey: String = options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String
        if urlKey == "com.sina.weibo" {
            //            微博回调
            return WeiboSDK.handleOpen(url, delegate: self)
        }
        return true
    }
    
    
    func weiBoConfig()
    {
        WeiboSDK.enableDebugMode(true)
        WeiboSDK.registerApp(WeiBoAppKey)
    }
    
}

