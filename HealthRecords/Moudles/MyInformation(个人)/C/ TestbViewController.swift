//
//   TestbViewController.swift
//  HealthRecords
//
//  Created by kys-2 on 2018/4/18.
//  Copyright © 2018年 kys-20. All rights reserved.
//

import Foundation
import UIKit


class TestbViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
     var tableView1:UITableView?
    var allnames:Dictionary<Int, [String]>?
    override func loadView() {
        super.loadView()
    }
    
  override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "设置"
       
    self.allnames = [0:[String](["新信息提醒","下载设置"]),
    1:[String](["修改密码"]),
    2:[String](["检测新版本"])]
    self.tableView1 = UITableView(frame:self.view.frame, style:.grouped)
    self.tableView1!.delegate = self
    self.tableView1!.dataSource = self
    self.tableView1!.register(UITableViewCell.self,
                              forCellReuseIdentifier: "SwiftCell")
    self.tableView1!.estimatedRowHeight = 60.0
    self.tableView1!.rowHeight = UITableViewAutomaticDimension;
    self.view.addSubview(self.tableView1!)
    let button:UIButton = UIButton(type:.custom)
    button.frame = CGRect(x:0,y:HEIGHT/2,width:WIDTH,height:40)
    button.setTitle("退出",for:.normal)
//    button.layer.borderWidth = 0.2
    button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
    button.backgroundColor = .white
    button.setTitleColor(UIColor.black,for:.normal)
    button.addTarget(self, action: #selector(enter(_:)), for: .touchUpInside)
    self.view.addSubview(button)
    
   
    
}
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3;
    }
    
    //返回表格行数（也就是返回控件数）
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let data = self.allnames?[section]
        return data!.count
    }
    //创建各单元显示内容(创建参数indexPath指定的单元）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            //为了提供表格显示性能，已创建完成的单元需重复使用
            let identify:String = "SwiftCell"
            //同一形式的单元格重复使用，在声明时已注册
            let cell = tableView.dequeueReusableCell(
                withIdentifier: identify, for: indexPath)
            
            cell.accessoryType = .disclosureIndicator
            
            let secno = indexPath.section
            
            var data = self.allnames?[secno]
            
            cell.textLabel?.text = data![indexPath.row]
            
            
            return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 83/1135*HEIGHT
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 17/1135*HEIGHT
    }
    
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
   }
//    点击退出登录
    @objc func enter(_ button:UIButton)
    {
      let appleDelagate = UIApplication.shared.delegate as! AppDelegate
        appleDelagate.setUpTheWindowConfig()
    }
}
