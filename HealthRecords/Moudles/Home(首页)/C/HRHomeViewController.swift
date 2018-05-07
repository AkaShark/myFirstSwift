//
//  HRHomeViewController.swift
//  HealthRecords
//
//  Created by kys-20 on 2018/4/17.
//  Copyright © 2018年 kys-20. All rights reserved.
//

import UIKit
import SnapKit
import Cards
import Kingfisher
import Alamofire
import SwiftyJSON

class HRHomeViewController: HRBaseViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    /// cell图片数据
    var cellImageData: NSArray?
    var cellTitleData: NSArray?
    var cellSubTitle: NSArray?
    
    var content: String?
    var titl = String()
    /// 轮播图的数据
    var headImageData: NSArray?
    var headTitleData: NSArray?
    
    override func viewWillAppear(_ animated: Bool)
    {
        //        网络获取数据
        self.getTheRequest()
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.changeNavTitle(navTitleName: "首页")
        
        headImageData = ["http://pimg.39.net/PictureLib/A/f76/20171027/org_2212794.jpg","http://pimg.39.net/PictureLib/A/f76/20171027/org_2212770.jpg","http://pimg.39.net/PictureLib/A/f76/20170915/org_1948987.jpg","http://pimg.39.net/PictureLib/A/f76/20171027/org_2212785.jpg"]
        headTitleData = ["第373期仰睡 俯睡 侧睡,哪种睡姿最健康","每天一包烟和每天一支烟危害有多大","喝骨头汤=补钙?实验证明不如一盒牛奶","早睡早起的人,身体会有7个大变化"]
        
        
        ///  tableView
        self.lazyTableView.delegate = self
        self.lazyTableView.dataSource = self
//        showVerticalScrollIndicator 为显示纵向的滑动条 H那个为横向的
        self.lazyTableView.showsVerticalScrollIndicator = false
        self.view.addSubview(self.lazyTableView)
        
        // Do any additional setup after loading the view.
    }
    
    
    /// 网络请求
    func getTheRequest() -> ()
    {
        Alamofire.request("http://route.showapi.com/883-1?showapi_appid=47729&showapi_sign=5639e00bf4b7422995a432b630969ff1&url=http://health.sina.com.cn/d/2018-04-26/doc-ifzcyxmv4569797.shtml", method: HTTPMethod.get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            
            if response.error == nil{
                let value = response.result.value
                let json = JSON(value ?? "没有数据")
                let contentTxt = json["showapi_res_body"]["content"].string
                let titleTxt = json["showapi_res_body"]["title"].string
                
                //                print(response.result.value ?? "没有数据")
//                print(contentTxt!)
                self.content = contentTxt
                self.titl = titleTxt!
                self.lazyTableView.reloadData()
            }
            
        }
    }
    
    //    刷新tableView
    override func headerRereshing()
    {
        self.headImageData = ["http://pimg.39.net/PictureLib/A/f76/20151222/org_605976.jpg","http://pimg.39.net/PictureLib/A/f76/20150715/org_468820.jpg","http://pimg.39.net/PictureLib/A/f76/20150713/org_467597.jpg","http://pimg.39.net/PictureLib/A/f76/20150709/org_463139.jpg"]
        self.headTitleData = ["惊呆！吃一口垃圾食品竟要运动4小时","宅女小心 坐得越久患癌风险越高","一个简单测试 预知心血管疾病风险","从体毛看你身体是否健康"]
        self.lazyTableView.mj_header.endRefreshing()
        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Table
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        if section == 1 {
            return 1
        }
        else
        {
            return 3
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        添加头部
        let headView = HRHomeHeadVIew(frame: CGRect(x: 0, y: 20, width: WIDTH, height:450/1134*HEIGHT), imageArray: headImageData as! Array<String>,titleName:headTitleData as! Array<String>)
        headView.delegate = self
        self.lazyTableView.tableHeaderView = headView
        
        if indexPath.section == 0
        {
            let cell = HRHomeMiddleTableViewCell(style: .default, reuseIdentifier: "Mid")
            cell.setUpUI(imageName: "BE15FC9429B68F04DB3C16D12AA8830E")
            cell.selectionStyle = .none
            return cell
        }
        if indexPath.section == 2
        {
            if indexPath.row == 0
            {
                let vc1 = HRHomePopNewsViewController()
                vc1.contentTxt = self.content
                vc1.titleTxt = self.titl
                let vc2 = HRHomePopNewsViewController()
                vc2.contentTxt = self.content
                vc2.titleTxt = self.titl
                
                let cell = HRHomeTableViewCell(style: .default, reuseIdentifier: "NewData")
                cell.setUpUI(imageName:"15249957597446fd0aa0a09.jpeg" , titleName: "什么时间时候吃枸杞", subTitle: " ", presentVC: vc1, FromVC: self)
                cell.setUpUI1(imageName:"1120530.jpg" , titleName: "生活压力太大怎么放松", subTitle: " ", presentVC: vc2, FromVC: self)
                cell.selectionStyle = .none
                return cell
            }
            else if indexPath.row == 1
            {
                let vc1 = HRHomePopNewsViewController()
                vc1.contentTxt = self.content
                vc1.titleTxt = self.titl
                let vc2 = HRHomePopNewsViewController()
                vc2.contentTxt = self.content
                vc2.titleTxt = self.titl
                
                let cell = HRHomeTableViewCell(style: .default, reuseIdentifier: "NewData")
               
                cell.setUpUI(imageName:"6c3d000426713f01cadb.jpeg" , titleName: "哪些对我们影响很大的蔬菜", subTitle: " ", presentVC: vc1, FromVC: self)
                
                cell.setUpUI1(imageName:"12_140909144716_1.jpg" , titleName: "每天早上起来最该做的事", subTitle: " ", presentVC: vc2, FromVC: self)
                cell.selectionStyle = .none
                return cell
            }
            else
            {
                let vc1 = HRHomePopNewsViewController()
                vc1.contentTxt = self.content
                vc1.titleTxt = self.titl
                let vc2 = HRHomePopNewsViewController()
                vc2.contentTxt = self.content
                vc2.titleTxt = self.titl
                
                let cell = HRHomeTableViewCell(style: .default, reuseIdentifier: "NewData")
                
                cell.setUpUI(imageName:"1005520.jpg" , titleName: "人体十二大器官最爱这些食物", subTitle: " ", presentVC: vc1, FromVC: self)
                
                cell.setUpUI1(imageName:"1345100.jpg" , titleName: "脚扭伤肿了怎么消肿", subTitle: " ", presentVC: vc2, FromVC: self)
                cell.selectionStyle = .none
                return cell
            }
           
        }
        else
        {
            let cell = HRHomeSectionTableViewCell(style: .default, reuseIdentifier: "sectionCell")
            cell.cellDelegate = self
            cell.setUpTheView(titleName:"健康头条" , btnName: "更多", imageName: "箭头")
            cell.selectionStyle = .none
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 20/1134*HEIGHT
        }
        if section == 1 {
            return 0
        }
        else
        {
            return 0
        }
       
    }
    
    //    tableViewcell高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if indexPath.section == 0
        {
            return 50
        }
        if indexPath.section == 2
        {
            return 240
        }
        else
        {
            return 70/1136*HEIGHT
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0
        {
            return 20/1134*HEIGHT
        }
        else
        {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if indexPath.section == 0
        {
            let vc = HRHomeMDViewController()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    
    //    状态栏改变
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        //        print(scrollView.contentOffset.y)
        
        
        if Int(scrollView.contentOffset.y) < Int(456/1134*HEIGHT)
        {
            self.navigationController?.setNavigationBarHidden(false, animated: true)
            
        }
        if Int(scrollView.contentOffset.y) >= Int(456/1134*HEIGHT)
        {
            //            导航栏隐藏 状态栏变色
            self.navigationController?.setNavigationBarHidden(true, animated: true)
            UIApplication.shared.statusBarStyle = .default
        }
        
    }
    
    
    
}

