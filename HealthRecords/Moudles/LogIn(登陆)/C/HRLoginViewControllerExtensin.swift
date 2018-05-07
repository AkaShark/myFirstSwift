
//
//  HRLoginViewControllerExtensin.swift
//  HealthRecords
//
//  Created by kys-20 on 2018/5/1.
//  Copyright © 2018年 kys-20. All rights reserved.
//

import Foundation

extension HRLoginViewController: touchTheThirdLogIn
{
    func touchTheThirdLogin(index: Int) {
        if index == 0
        {
            let request : WBAuthorizeRequest = WBAuthorizeRequest.request() as! WBAuthorizeRequest
            request.redirectURI = "https://api.weibo.com/oauth2/default.html"
            request.scope = "all"
            request.userInfo = ["SSO_Key":"SSO_Value"]
            WeiboSDK.send(request)
        }
        else if index == 1
        {
            
        }
        else
        {
            
        }
    }
    
    
    
}

