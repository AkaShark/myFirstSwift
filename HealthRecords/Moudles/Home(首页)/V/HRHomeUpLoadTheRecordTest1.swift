//
//  HRHomeUpLoadTheRecordTest1.swift
//  HealthRecords
//
//  Created by kys-20 on 2018/5/3.
//  Copyright © 2018年 kys-20. All rights reserved.
//

import UIKit

class HRHomeUpLoadTheRecordTest1: UIView
{
    var horizontView: UIStackView?
    init(frame: CGRect,title: String,line: Int)
    {
        super.init(frame:frame)
        horizontView = UIStackView()
        horizontView?.axis = .horizontal
        horizontView?.distribution = .fillEqually
        horizontView?.spacing = 2
        horizontView?.alignment = .fill
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp(titleArray:String,Line:Int) -> () {
        
    }
    
  

}
