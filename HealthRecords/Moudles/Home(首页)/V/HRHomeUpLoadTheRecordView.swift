//
//  HRHomeUpLoadTheRecordView.swift
//  HealthRecords
//
//  Created by kys-20 on 2018/4/27.
//  Copyright © 2018年 kys-20. All rights reserved.
//

import UIKit

/// 动态创建视图 （考虑传进来的是什么 宽度和文字）
class HRHomeUpLoadTheRecordView: UIView,UITextFieldDelegate
{
    ///
    ///
    /// - Parameters:
    ///   - frame: <#frame description#>
    ///   - titleArray: <#titleArray description#>
    init(frame:CGRect,titleArray:Array<Array<Any>>,line: Int)
    {
        
        super.init(frame: frame)
        self.setUpUI(titleArray: titleArray, line: line)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 创造视图
    ///位置是相对有self。。。哎。算了半天
    /// - Parameter titleArray:
    func setUpUI(titleArray:Array<Array<Any>>,line:Int) -> ()
    {
        for i in 0..<titleArray.count
        {
//            let textFiled = UITextField(frame:CGRect(x: titleArray[i]["X"] as! CGFloat, y: titleArray[i]["Y"] as! CGFloat, width: titleArray[i]["Width"] as! CGFloat, height:titleArray[i]["Height"] as! CGFloat))
            let textFiled = UITextField(frame: CGRect(x: CGFloat(i)*WIDTH/CGFloat(titleArray.count), y:0, width:WIDTH/CGFloat(titleArray.count), height: 80))
            textFiled.text = titleArray[i][0] as? String
            textFiled.layer.borderWidth = 1
            textFiled.layer.borderColor = UIColor(red: 244/255.0, green: 244/255.0, blue: 244/255.0, alpha: 1).cgColor
            textFiled.layer.masksToBounds = true
            textFiled.delegate = self
            self.addSubview(textFiled)
        }
    }
    
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        textField.layer.borderWidth = 0
//        textField.layer.borderColor = UIColor.clear.cgColor
//    }
    
    


}
