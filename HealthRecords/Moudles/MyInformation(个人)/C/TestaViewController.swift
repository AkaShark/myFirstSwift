//
//  TestViewController.swift
//  HealthRecords
//
//  Created by kys-2 on 2018/4/18.
//  Copyright © 2018年 kys-20. All rights reserved.
//


import UIKit
var label = UILabel()
var label1 = UILabel()
let img = UIImageView()
class TestaViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
           self.title = "关于我们"
        
        let View1 = UIView()
        View1.frame = CGRect(x:0,y:0,width:WIDTH,height:HEIGHT)
        View1.backgroundColor = UIColor.white
        self.view.addSubview(View1)
        
        img.frame = CGRect(x:WIDTH/3+20,y:HEIGHT/18,width:WIDTH/4.5,height:HEIGHT/8)
        self.view.addSubview(img)
        img.image = UIImage.init(named: "关于我们")
        
        
        label.frame = CGRect(x:0,y:HEIGHT/4,width:WIDTH,height:80)
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.black
        label.textAlignment = .center
//        label.text = "客服电话"
        label.numberOfLines = 0
        label.backgroundColor = UIColor.white
        self.view.addSubview(label)
        
        label1.frame = CGRect(x:0,y:HEIGHT-200,width:WIDTH,height:100)
        label1.font = UIFont.systemFont(ofSize: 10)
        label1.textColor = UIColor.red
        label1.textAlignment = .center
        label1.numberOfLines = 0
        label1.text = "Copyright@2018 Yiban inc\n All Rights Reserved"
        label1.backgroundColor = UIColor.white
        self.view.addSubview(label1)
        
        
    }
    
}


