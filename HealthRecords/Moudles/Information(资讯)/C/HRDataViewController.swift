//
//  HRDataViewController.swift
//  HealthRecords
//
//  Created by kys-3 on 2018/4/20.
//  Copyright © 2018年 kys-20. All rights reserved.
//

import UIKit
import HandyJSON
import Kingfisher
/// 复用的c传递根据传递的参数model传递数据显示不同的数据
class HRDataViewController: HRBaseViewController,UITableViewDelegate,UITableViewDataSource
{
    var dataArray: Array<Array<Any>>?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //        tableView
        self.lazyTableView.delegate = self
        self.lazyTableView.dataSource = self
        self.lazyTableView.frame = CGRect(x: 0, y: 0, width: WIDTH, height: HEIGHT-162)
        self.view.addSubview(self.lazyTableView)
        
        // Do any additional setup after loading the view.
    }
    func giveTheData(data: Array<Any>) -> ()
    {
        self.dataArray = data as? Array<Array<Any>>
        self.lazyTableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.dataArray == nil
        {
            return 1
        }
        else{
            return (self.dataArray!.count)
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = HRDatumTableViewCell(style: .default, reuseIdentifier: "newsCell")
        cell.selectionStyle = .none
        if self.dataArray != nil {
            cell.leftImageView.kf.setImage(with: URL(string: (self.dataArray![indexPath.row][1] as? String)!))
        }
        cell.titleLabel.text = (self.dataArray?[indexPath.row][3] as? String)
        cell.detailLabel.text = (self.dataArray?[indexPath.row][2] as? String)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170/1134*HEIGHT
    }
    
    //    cell 点击事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let urlString = "https://www.jkyd.net/"+(self.dataArray![indexPath.row][0] as! String)
        let wkWebViewController: WKWebviewController = WKWebviewController()
        wkWebViewController.urlString = urlString
        wkWebViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(wkWebViewController, animated: true)
    }
//    刷新方法
    override func headerRereshing()
    {
        self.dataArray?.reverse()
        self.lazyTableView.reloadData()
        self.lazyTableView.mj_header.endRefreshing()
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

