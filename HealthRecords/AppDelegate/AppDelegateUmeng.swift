//
//  AppDelegateUmeng.swift
//  HealthRecords
//
//  Created by kys-20 on 2018/5/1.
//  Copyright © 2018年 kys-20. All rights reserved.
//

import Foundation

extension AppDelegate
{
    func uMengConfig() -> ()
    {
        UMSocialManager.default().openLog(true)
        UMSocialGlobal.shareInstance().isClearCacheWhenGetUserInfo = false
        UMSocialManager.default().umSocialAppkey = "5861e5daf5ade41326001eab"
        //        UMSocialManager.default().setPlaform(UMSocialPlatformType.wechatSession, appKey: "wxdc1e388c3822c80b", appSecret: "3baf1193c85774b3fd9d18447d76cab0", redirectURL: "http://mobile.umeng.com/social")
        //        UMSocialManager.default().setPlaform(UMSocialPlatformType.QQ, appKey: "1105821097", appSecret: nil, redirectURL: "http://mobile.umeng.com/social")
        UMSocialManager.default().setPlaform(UMSocialPlatformType.wechatFavorite, appKey: "wxdc1e388c3822c80b", appSecret: "3baf1193c85774b3fd9d18447d76cab0", redirectURL: "http://mobile.umeng.com/social")
        UMSocialManager.default().setPlaform(UMSocialPlatformType.QQ, appKey: "1105821097", appSecret: nil, redirectURL: "http://mobile.umeng.com/social")
    }
  
}

