//
//  HRBaseNavigationController.swift
//  HealthRecords
//
//  Created by kys-20 on 2018/4/14.
//  Copyright © 2018年 kys-20. All rights reserved.
//

import UIKit

/// 对应导航栏的封装。不好。应该将BaseView中的添加返回按钮的地方改到这里来 再添加手势 但是由于时间的原因暂时这样 以后再作调整 ~ （不是很复杂）
class HRBaseNavigationController: UINavigationController
{
    
    /// 是否开启返回手势
   open var isSystemSlidBack:Bool?
    
    /// screen边缘滑动手势
//    var popRecognizer: UIScreenEdgePanGestureRecognizer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        someSystemConfig()
        // Do any additional setup after loading the view.
    }
///    基础的设置
    func someSystemConfig()
    {
        let navBar = UINavigationBar.appearance()
        navBar.barTintColor = NavBgColor
        navBar.tintColor = NavBGFontColor
//        navBar.titleTextAttributes =  [NSAttributedStringKey.foregroundColor: UIColor.white]
        navBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:NavBGFontColor,NSAttributedStringKey.font:UIFont.systemFont(ofSize: 18)]
//        位置要写对44的话状态栏没有显示是黑色的。。。！ 64隐藏了状态栏后导航栏就会显示全部了
        navBar.setBackgroundImage(UIColor.createImage(color: NavBgColor, size: CGSize(width: WIDTH, height: 64)), for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
        navBar.shadowImage = UIImage()
        
    }
    
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
