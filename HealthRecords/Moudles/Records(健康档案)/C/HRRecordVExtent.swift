//
//  HRRecordVExtent.swift
//  HealthRecords
//
//  Created by kys-20 on 2018/4/23.
//  Copyright © 2018年 kys-20. All rights reserved.
//

import Foundation

// MARK: - 点击btn的代理事件
extension HRRecordsViewController:tureToTheRecordDelegate,HRSelectTheFamilyMembers
{
   
    
//    选择家庭成员的代理
    func selectedTheFamilyMembers()
    {
        let vc = HRHomeBtnThirdCellClickViewController()
        vc.merberDelegate = self
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
/// 中间按钮的代理
    func toTheRecord(btnTitle: String,index: Int)
    {
        let vc = HRPersonRecordsViewController()
        vc.btnTitle = btnTitle
        vc.index = index
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
//    选完成员的回调
    func passTheSelectedMember(objID: String, labelTxt: String) {
       self.userName = labelTxt
        self.lazyTableView.reloadData()
    }
    
}
