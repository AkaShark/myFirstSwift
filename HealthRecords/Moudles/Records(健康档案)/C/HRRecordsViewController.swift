//
//  HRRecordsViewController.swift
//  HealthRecords
//
//  Created by kys-20 on 2018/4/20.
//  Copyright © 2018年 kys-20. All rights reserved.
//

import UIKit

class HRRecordsViewController: HRBaseViewController,UITableViewDelegate,UITableViewDataSource,homeTableViewCellClickDelegate
{
    
    let stateView = UIView(frame: CGRect(x: 0, y: 0, width: WIDTH, height: 20))
    
    var patientHospital: String?
    var medicinalTime: String?
    var hospitalOffice: String?
    
    var userName:String?
    
    override func viewWillAppear(_ animated: Bool)
    {
        stateView.backgroundColor = MainColor
        stateView.tag = 1000
        self.view.addSubview(stateView)
        self.navigationController?.navigationBar.isHidden = true
        self.downLoadTheRecord()
        

        
    }
    
    
    /// 请求数据 (开始没有设计好 这个界面请求完直接传给下一个界面。。。再次请求没处理好)
    func downLoadTheRecord()
    {
        let query: BmobQuery = BmobQuery(className: "medicinalRecord")
        query.findObjectsInBackground { (array, error) in
            if error != nil
            {
                print(error!)
            }
            else
            {
//                print(array!)
                //                获取数据
                for i in 0..<array!.count
                {
                    let obj = array![i] as! BmobObject
                    
                    self.patientHospital = obj.object(forKey: "patientHospital")as? String
                    self.medicinalTime = obj.object(forKey: "medicinalTime") as? String
                    self.hospitalOffice = obj.object(forKey: "hospitalOffice") as? String
                }
                self.lazyTableView.reloadData()
                self.lazyTableView.mj_header.endRefreshing()
            }
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lazyTableView.delegate = self
        self.lazyTableView.dataSource = self

        //        ~~~ 请求当前用户
        userName = BmobUser.current().username
        self.lazyTableView.reloadData()
        
        self.view.addSubview(self.lazyTableView)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //    MARK:- tableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        获取数据数组再进行判断
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        
        let header = HRRecordsHeadView(frame: CGRect(x: 0, y: 0, width: WIDTH, height: 1090/2203*HEIGHT), userImage: "头像", userName: userName!, titleName: ["体检报告","检验报告","检查报告","病历","处方","全部"], imageName: ["体检报告","检测报告","检查报告","病历","处方","全部"])
        header.delegate = self

        
        self.lazyTableView.tableHeaderView = header
        
        if indexPath.section == 0
        {
            let cell = HRHomeSectionTableViewCell(style: .default, reuseIdentifier: "recordsCell")
            cell.cellDelegate = self
            cell.setUpTheView(titleName: "最近报告", btnName: "更多", imageName: "箭头")
            cell.selectionStyle = .none
            return cell
        }
        if indexPath.section == 1
        {
            let cell = HRRecordsRecentlyTableViewCell(style: .default, reuseIdentifier: "recordsRecently")
            cell.setUpUI(timeText: self.medicinalTime ?? "", hospitalTitle: self.patientHospital ?? "没有记录", speciesTitle: self.hospitalOffice ?? "")
            cell.seccoLable.isHidden = true
            cell.hospitalLabel.textAlignment = .center
            cell.selectionStyle = .none
            return cell
        }
        if indexPath.section == 2
        {
            let cell = HRHomeSectionTableViewCell(style: .default, reuseIdentifier: "errorReportcell")
            cell.setUpTheView(titleName: "异常报告", btnName: "", imageName: "")
            cell.selectionStyle = .none
            return cell
        }
        else
        {
            let cell = HRHomeMiddleTableViewCell(style: .default, reuseIdentifier: "imageCell")
//            赶时间的做法 不然的话可以考虑去刷新tableVIew或者刷新cell 或者考虑用kvo监听属性修改宽度
            cell.selectionStyle = .none
            cell.setUpUI1(imageName: "异常报告")
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section != 3 {
            return 44
        }
        else
        {
            return 800/2205*HEIGHT
        }
    }
    
    
//    设置头部高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 32/2203*HEIGHT
        }
        if section == 1 {
            return 0
        }
        if section == 2 {
             return 32/2203*HEIGHT
        }
        else
        {
           return 0
        }
        
    }
//    滑动代理
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        if scrollView.contentOffset.y < -20
        {
            let stateView = self.view.viewWithTag(1000)
            stateView?.isHidden = true
        }
        if scrollView.contentOffset.y == -20
        {
            let stateView = self.view.viewWithTag(1000)
            //            stateView?.isHidden = false
            self.hidden(view: stateView!)
            
        }
        if scrollView.contentOffset.y > 0 {
            let stateView = self.view.viewWithTag(1000)
            stateView?.isHidden = true
        }
        
    }
    
    
    //    MARK:- 下拉刷新
    override func headerRereshing()
    {
        self.downLoadTheRecord()
    }
    
    //    MARK:-代理方法
    func clickTheMore()
    {
        self.navigationController?.pushViewController(HRPersonRecordsViewController(), animated: true)
        
        
    }
    
    
    
    
    
}

