//
//  HRHomePopNewsViewController.swift
//  HealthRecords
//
//  Created by kys-20 on 2018/4/24.
//  Copyright © 2018年 kys-20. All rights reserved.
//

import UIKit

class HRHomePopNewsViewController: HRBaseViewController {

    
    var contentTxt: String?
    var titleTxt : String?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let title1 = UILabel()
        title1.frame = CGRect(x:0,y:0,width:self.view.bounds.width,height:self.view.bounds.height/18)
        title1.textColor = UIColor.black
        
        title1.text = titleTxt
        
        title1.textAlignment = .left
        self.view.addSubview(title1)
        //        scrollView.addSubview(title)
        //随机数
        let temp = Int(arc4random()%100)+1
        
        let labeltitle = UILabel()
        labeltitle.frame = CGRect(x:0,y:title1.frame.size.height+title1.frame.origin.y ,width:self.view.bounds.width,height:self.view.bounds.height/23)
        labeltitle.textColor = UIColor.black
//        labeltitle.font = UIFont(name:"Zapfino", size:13)
        //        labeltitle.backgroundColor = .red
        labeltitle.text = "作者：XXX    阅读数："+String(temp)
        self.view.addSubview(labeltitle)
        
        //        scrollView.addSubview(labeltitle)
        
        //图片
        //        let image = UIImage.init(named: "下载.jpg")
        //        let imageView = UIImageView()
        //        imageView.frame = CGRect.init(x: 0, y:1/3*self.view.frame.size.height, width:  self.view.frame.size.width, height:1/3*self.view.frame.size.height )
        //        imageView.image = image
        
        
        //设置拉伸模式
        //        imageView.contentMode = UIViewContentMode.scaleAspectFill
        //        self.view.addSubview(imageView)
        //        scrollView.addSubview(imageView)
        
        let label = UILabel(frame:CGRect(x:0, y:1/10*self.view.frame.size.height, width:self.view.frame.size.width-60, height:self.view.frame.size.height))
        //        let label = UILabel()
        label.text = contentTxt
        
        label.textColor = UIColor.black //白色文字
        label.backgroundColor = UIColor.white //背景
        //        label.font = UIFont(name:"Zapfino", size:18)
        label.numberOfLines = 0  //（默认只显示一行，设为0表示没有行数限制）
        self.view.addSubview(label)
        
        // Do any additional setup after loading the view.
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
