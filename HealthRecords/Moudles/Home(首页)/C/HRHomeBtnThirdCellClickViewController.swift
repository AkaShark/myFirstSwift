//
//  HRHomeBtnThirdCellClickViewController.swift
//  HealthRecords
//
//  Created by kys-3 on 2018/4/23.
//  Copyright © 2018年 kys-20. All rights reserved.
//

import UIKit
import PKHUD

protocol HRHomeBtnThirdCellClickViewControllerDelegate
{
    func avatorCellClick(objID:String, labelTxt:NSString,cell:HRHomeBtnUploadTableViewCell)
}
protocol HRSelectTheFamilyMembers
{
    func passTheSelectedMember(objID: String, labelTxt: String)
}
//typealias passTheName = (_ objID: String, _ labelTxt: String) -> Void

class HRHomeBtnThirdCellClickViewController: HRBaseViewController,UITableViewDelegate,UITableViewDataSource
{
    
    //    var passTheName: passTheName?
    
    var delegateTHIRD: HRHomeBtnThirdCellClickViewControllerDelegate?

    var merberDelegate: HRSelectTheFamilyMembers?
    
//    var canSelected: Bool = true
    
    var cell: HRHomeBtnUploadTableViewCell?
    var userList = Array<Any>()
    var objectID = Array<Any>()
    var relationList = Array<Any>()
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.addTheNavRightBtn()
        self.navigationController?.navigationBar.isHidden = false
        
    }
    
    func addTheNavRightBtn() -> ()
    {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named:"添加-5"), for: .normal)
        btn.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        btn.addTarget(self, action: #selector(addFamilyMembers), for: .touchUpInside)
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, -10)
        
        let item = UIBarButtonItem(customView: btn)
        
        self.navigationItem.rightBarButtonItem = item
    }
    
    //    MARK:-添加家庭成员
    @objc func addFamilyMembers() -> ()
    {
        let vc = AMNewAddressViewController()
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    //    MARK:- 获取家庭成员列表
    
    func getTheUserList() -> ()
    {
//        显示获取中
        HUD.show(.label("正在获取就诊人"))
        self.userList.removeAll()
        self.objectID.removeAll()
        self.relationList.removeAll()
        
        let user = BmobUser.current()
        let query: BmobQuery = BmobQuery(className: "homeGroup")
        //        获取到userlist
        query.whereKey("userPhone", equalTo: user?.username!)
        query.findObjectsInBackground { (arry, error) in
            if error != nil
            {
                print("获取家庭成员列表失败")
            }
            else
            {
//                隐藏
                HUD.hide(afterDelay: 0.5)
                
                for i in 0..<(arry?.count)!{
                    let obj = arry![i] as! BmobObject
                    let objectID = obj.objectId
                    let patientName = obj.object(forKey: "patientName")
                    let relation = obj.object(forKey: "relation")
                    
                    self.relationList.append(relation!)
                    self.objectID.append(objectID!)
                    self.userList.append(patientName!)
                }
                self.lazyTableView.mj_header.endRefreshing()
                self.lazyTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.changeNavTitle(navTitleName: "家庭成员")
        self.setIsShowLiftBakc(ShowLiftBack: true)
        
        //        获取用户名
        self.getTheUserList()
        self.lazyTableView.delegate = self
        self.lazyTableView.dataSource = self
        lazyTableView.tableFooterView = UIView(frame: CGRect.zero)
        self.view.addSubview(lazyTableView)
        
        // Do any additional setup after loading the view.
    }
    
    override func headerRereshing()
    {
        self.getTheUserList()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.userList.count == 0
        {
            return 1
        }
        else
        {
            return (self.userList.count)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = HRHomeBtnThirdCellClickTableViewCell(style: .default, reuseIdentifier: "cellId")
        if self.userList.count == 0
        {
            
        }
        else{
            cell.txtLabel.text = userList[indexPath.row] as? String
            cell.lovedOne.text = relationList[indexPath.row] as? String
        }
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as?HRHomeBtnThirdCellClickTableViewCell
        let UserTxt = cell?.txtLabel?.text ?? String()
        cell?.selectImage.image = UIImage(named: "对勾.png")
        
        self.delegateTHIRD?.avatorCellClick(objID: self.objectID[indexPath.row] as! String, labelTxt: UserTxt as NSString, cell: self.cell!)
        
        self.merberDelegate?.passTheSelectedMember(objID: self.objectID[indexPath.row] as! String, labelTxt: (UserTxt as NSString) as String)
        //        if passTheName != nil
        //        {
        //            passTheName?(self.objectID[indexPath.row] as! String, UserTxt)
        //        }
        self.navigationController?.popViewController(animated: true)
        //        print(UserTxt)
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75/1004*HEIGHT
    }
    
    
    //    点击删除按钮响应的方法 对应逻辑的处理
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        //        删除数据源的对应数据
        self.userList.remove(at: indexPath.row)
        self.relationList.remove(at: indexPath.row)
        self.objectID.remove(at: indexPath.row)
        
        //        删除对应的cell
        if self.userList.count == 0
        {
            HUD.flash(.label("请至少保留一个就诊人"), delay: 0.5)
        }
        else
        {
            self.lazyTableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.top)
            
            //        bmob云后端删除
            let user: BmobObject = BmobObject(outDataWithClassName: "homeGroup", objectId: self.objectID[indexPath.row] as! String)
            user.deleteInBackground { (isSuccessful, error) in
                if isSuccessful
                {
                    //                删除成功后的操作
                    HUD.flash(.label("删除成功"), delay: 0.5)
                }
                else
                {
                    print("删除失败")
                }
            }
            
        }
        
    }
    //    返回编辑类型，滑动删除
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle
    {
        return UITableViewCellEditingStyle.delete
    }
    //    修改删除按钮的文字
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        
        return "删除成员"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

