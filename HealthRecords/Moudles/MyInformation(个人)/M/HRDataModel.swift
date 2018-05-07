//
//  HRDataModel.swift
//  HealthRecords
//
//  Created by kys-3 on 2018/4/16.
//  Copyright © 2018年 kys-20. All rights reserved.
//

import UIKit

class HRDataModel: NSObject {
    
    
    
    var titleName : Array<Any>!
    var imageV :Array<Any>!
    
    
    
    override init() {
        super.init()
    }
    
    init(data:Array<Any>,imageData:Array<Any>) {
        titleName = data
        imageV = imageData
    }
    
   
    
}
