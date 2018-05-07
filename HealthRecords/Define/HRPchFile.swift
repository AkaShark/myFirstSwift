//
//  HRPchFile.swift
//  HealthRecords
//
//  Created by kys-20 on 2018/4/10.
//  Copyright © 2018年 kys-20. All rights reserved.
//

import Foundation
import UIKit


/// 整个屏幕的宽高
let HEIGHT = UIScreen.main.bounds.size.height
let WIDTH = UIScreen.main.bounds.size.width


/// 基调颜色
let StandColor = UIColor(red: 100/255.0, green: 100/255.0, blue:100/255.0 , alpha: 1)

/// 大部分VC的颜色
let MainBackGroundColor = UIColor.white

/// 登陆注册的btn的宽高
let LoginBtnW = 830/1012*WIDTH
let LoginBtnH = 105/1808*HEIGHT


let StandGray = UIColor(red: 135/255.0, green: 135/255.0, blue: 135/255.0, alpha: 1)

let kStatusBarHeight = UIApplication.shared.statusBarFrame.size.height

let kNavBarHeight = 44.0

let kTabBarHeight = 49 

///
let kTopHeight = (kStatusBarHeight+CGFloat(kNavBarHeight))


/// 定义分别为大字号中字号小字号
let mainFont = UIFont.systemFont(ofSize: 17)
let secondFont = UIFont.systemFont(ofSize: 14)
let thirdFont = UIFont.systemFont(ofSize: 12)
/// 设置导航栏的颜色
let NavBgColor = UIColor(red: 38/255.0, green: 212/255.0, blue: 136/255.0, alpha: 1)

//let NavBgColor = UIColor(red: 253/255.0, green: 119/255.0, blue: 121/255.0, alpha: 1)
/// 设置导航栏标题的颜色
let NavBGFontColor = UIColor.white

let MainColor = UIColor(red: 38/255.0, green: 212/255.0, blue: 136/255.0, alpha: 1)

let WeiBoAppKey = "2078470246"

let WeiBoURL = "http://www.sina.com"


let webProgressColor = UIColor(red: 237/255.0, green: 48/255.0, blue: 140/255.0, alpha: 1)







