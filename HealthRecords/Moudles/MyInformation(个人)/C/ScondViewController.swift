//
//  ScondViewController.swift
//  HealthRecords
//
//  Created by kys-2 on 2018/4/18.
//  Copyright © 2018年 kys-20. All rights reserved.
//

import Foundation
import UIKit
class ScondViewController:UIViewController,UITableViewDataSource,UITableViewDelegate{
    var tableView:UITableView?
    var allnames1:Dictionary<Int, [String]>?
    let imge = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我的信息"
        self.allnames1 = [0:[String](["头像"]),
                         1:[String](["昵称","手机号码"]),]
        self.tableView = UITableView(frame:self.view.frame, style:.grouped)
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
    self.tableView!.register(UITableViewCell.self,forCellReuseIdentifier: "SwiftCell")
        self.tableView!.estimatedRowHeight = 60.0
        self.tableView!.rowHeight = UITableViewAutomaticDimension;
        self.view.addSubview(self.tableView!)
   
      
        }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0{
            return 110/1135*HEIGHT
            
        }
        else {
            return 83/1135*HEIGHT
            
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2;
    }
    
    //返回表格行数（也就是返回控件数）
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let title = self.allnames1?[section]
        return title!.count
    }
    //创建各单元显示内容(创建参数indexPath指定的单元）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            
            if indexPath.section == 0{
            let cell = HRUserClickTableViewCell(style: .default, reuseIdentifier: "CellIdentify")
            cell.accessoryType = .disclosureIndicator
            return cell
                
            }else{
                //为了提供表格显示性能，已创建完成的单元需重复使用
                let identify:String = "SwiftCell"
                //同一形式的单元格重复使用，在声明时已注册
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: identify, for: indexPath)
      
                cell.accessoryType = .disclosureIndicator
                
                let secno = indexPath.section
                
                var data = self.allnames1?[secno]
                
                cell.textLabel?.text = data![indexPath.row]
                return cell
            }
            
    }
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          self.tableView!.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 {
            let alertController = UIAlertController(title: "系统提示", message: "请进行头像选择",preferredStyle: .actionSheet)
            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            let deleteAction = UIAlertAction(title: "相机", style: .destructive, handler: nil)
            let archiveAction = UIAlertAction(title: "本地相册", style: .default, handler: nil)
            alertController.addAction(cancelAction)
            alertController.addAction(deleteAction)
            alertController.addAction(archiveAction)
            self.present(alertController, animated: true, completion: nil)
            }
    }
}
