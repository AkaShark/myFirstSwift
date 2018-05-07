//
//  Test5ViewController.swift
//  HealthRecords
//
//  Created by kys-20 on 2018/4/18.
//  Copyright © 2018年 kys-20. All rights reserved.
//

import UIKit
import Alamofire

class Test5ViewController: HRBaseViewController {
    
    var container = GTagFlowContainer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
        let btn = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        btn.backgroundColor = .white
        btn.addTarget(self, action: #selector(touch), for: .touchUpInside)
        self.view.addSubview(btn)
        
        container.flowView.configTagCollectionViewLayout()
        container.actionBtnItems = ["确定"]
        container.actionBlock = {(actionTitle,newText) in
            print(actionTitle!,newText!)
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    @objc func touch()
    {
        var array = GBigbangBox.bigBang("WHO标准亚洲标准中国标准相关病发病危险性")
        let addBtn = GBigbangItem.bigbangText("如果行数少于分词数请点击添加项", isSymbol: false)
        let emptyBtn0 = GBigbangItem.bigbangText("添加项", isSymbol: false)
        let emptyBtn1 = GBigbangItem.bigbangText("添加项", isSymbol: false)
        let emptyBtn2 = GBigbangItem.bigbangText("添加项", isSymbol: false)
        let emptyBtn3 = GBigbangItem.bigbangText("添加项", isSymbol: false)
        let emptyBtn4 = GBigbangItem.bigbangText("添加项", isSymbol: false)
        
        array?.append(addBtn!)
        array?.append(emptyBtn0!)
        array?.append(emptyBtn1!)
        array?.append(emptyBtn2!)
        array?.append(emptyBtn3!)
        array?.append(emptyBtn4!)
        
        let layouts = GTagFlowItem.factoryFolwLayout(with: array, with: nil)
        container.configDatas(layouts)
        container.show()
        
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

