//
//  HRHomeViewControllerExtent.swift
//  HealthRecords
//
//  Created by kys-20 on 2018/4/20.
//  Copyright © 2018年 kys-20. All rights reserved.
//

import Foundation

extension HRHomeViewController: homeTableViewCellClickDelegate,homeBtnClickDelegate
{
//    点击更多按钮
    func clickTheMore()
    {
        /// 将tabbar转为原来的类型 可以调用其方法
        let tab = self.navigationController?.tabBarController as! AnimationTabBarController
//        获取父类的方法
//        print(self.navigationController?.tabBarController?.superclass ?? AnyClass.self)
//        调用父类的方法
        tab.setSelectIndex(from: 0, to: 2)
    }
    
    func homeBtnClickDelegate(index: Int)
    {
        if index == 0
        {
            let vc = HRHomeUpLoadTheRecordViewController()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if index == 2
        {
            let tab = self.navigationController?.tabBarController as! AnimationTabBarController
            //        获取父类的方法
            //        print(self.navigationController?.tabBarController?.superclass ?? AnyClass.self)
            //        调用父类的方法
            tab.setSelectIndex(from: 0, to: 1)
        }
        else
        {
            let vc = HRPersonRecordsViewController()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
}

