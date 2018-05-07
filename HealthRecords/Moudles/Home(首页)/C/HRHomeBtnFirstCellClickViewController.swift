//
//  HRHomeBtnCellClickViewController.swift
//  HealthRecords
//
//  Created by kys-3 on 2018/4/22.
//  Copyright © 2018年 kys-20. All rights reserved.
//

import UIKit


protocol HRHomeBtnFirstCellClickViewControllerDelegate
{
    func cellClick(cellTxt: String,cell: HRHomeBtnUploadTableViewCell)
}

class HRHomeBtnFirstCellClickViewController: HRBaseViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    var delegate: HRHomeBtnFirstCellClickViewControllerDelegate?
    var array : Array <Any>!
    
    var cell: HRHomeBtnUploadTableViewCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.changeNavTitle(navTitleName: "选择报告类型")
        self.setIsShowLiftBakc(ShowLiftBack: true)
        array = ["检验","检查","体检","病历","处方","其他 "]
        
        
        let tableView = lazyTableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        self.view.addSubview(tableView)
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "reuseIdentifier")
        cell.selectionStyle = .none
        cell.textLabel?.text = (array as! Array<String>)[indexPath.row]
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        let cell = tableView.cellForRow(at: indexPath)
        
        let cellText = cell?.textLabel?.text ?? String()
        
        self.delegate?.cellClick(cellTxt: cellText, cell:self.cell!)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85/1004*HEIGHT
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

