//
//  HRMyInformationTableViewController.swift
//  HealthRecords
//
//  Created by kys-3 on 2018/4/16.
//  Copyright © 2018年 kys-20. All rights reserved.
//

import UIKit

class HRMyInformationTableViewController: UITableViewController {

    var dataArray: HRDataModel!
    var dataArraytitle: HRDataModel!
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//     设置导航栏
        self.navigationItem.title = "我的"
        
        self.tableView = UITableView(frame: CGRect.init(x: 0, y: 0, width: WIDTH, height: HEIGHT), style: .grouped)
        let array = [""]
        let array1 = ["我的挂号","我的关注","我的收藏","家庭成员"]
        let array2 = ["我有话说","关于我们","设置"]
        let imageArray = ["用户名.png"]
        let imageArray1 = ["门诊挂号-2.png","我的关注.png","我的收藏full.png","头像 女孩.png"]
        let imageArray2 = ["消息框.png","关于我们.png","设置.png"]
        dataArray = HRDataModel(data: [array,array1,array2],imageData:[imageArray,imageArray1,imageArray2])
        
        self.tableView.reloadData()
       
      
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
  override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return dataArray.titleName.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (dataArray.titleName[section] as AnyObject).count
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 17/1135*HEIGHT
    }
    
 

override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.section == 0{
        let cell = HRScondTableViewCell(style: .default, reuseIdentifier: "CellID")
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        return cell
        
    }else{
        let cell = HRMyInformationTableViewCell(style: .default, reuseIdentifier: nil)
    
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        cell.upDataWithArray(array: [dataArray.titleName[indexPath.section]], imageArray: [dataArray.imageV[indexPath.section]],index: indexPath)
        return cell
    }
    
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0
        {
            
            return 120/1135*HEIGHT
            
        }
        else {
            return 83/1135*HEIGHT
            
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView!.deselectRow(at: indexPath, animated: true)
   
        if indexPath.section == 0 {
            let Scond = ScondViewController()
            Scond.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(Scond, animated: true)}
        if  indexPath.section == 2 && indexPath.row == 1{
            let Scond1 = AXHCollectionViewController()
            Scond1.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(Scond1, animated: true)}
        if  indexPath.section == 2 && indexPath.row == 2{
            let Scond2 = TestbViewController()
//            Scond2.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(Scond2, animated: true)}
        if indexPath.section == 1 && indexPath.row == 3
        {
            let vc = HRHomeBtnThirdCellClickViewController()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        }
    

}
