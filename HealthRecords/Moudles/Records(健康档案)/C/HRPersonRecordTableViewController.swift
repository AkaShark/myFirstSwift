//
//  HRPersonRecordTableViewController.swift
//  HealthRecords
//
//  Created by kys-20 on 2018/4/23.
//  Copyright © 2018年 kys-20. All rights reserved.
//

import UIKit
import SnapKit
class HRPersonRecordTableViewController: HRBaseViewController,UITableViewDelegate,UITableViewDataSource
{
    var timeWhereWhatArray: Array<Array<Any>>?
    var imageArray: Array<Array<Any>>?
    let imageView = UIImageView()
    

    /// 接受数据
    ///
    /// - Parameter data: 传过来的data包含所有数据（最后一个为图片）
    func giveTheHealthRecords(data:Array<Array<Any>>,imageData: Array<Array<Any>>) -> ()
    {
//        self.timeWhereWhatArray?.removeAll()
//        self.imageArray?.removeAll()
        
        self.timeWhereWhatArray = data
        self.imageArray = imageData
        self.timeWhereWhatArray?.reverse()
        self.imageArray?.reverse()
        self.lazyTableView.reloadData()
    }
//    无数据展位图
    override func showNoDataImage()
    {
       
    }
//    取出展位数据
    override func removeNoDataImage()
    {
        
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.showNoDataImage()
        
        self.lazyTableView.frame.size.height = self.lazyTableView.size.height - 70
        self.lazyTableView.delegate = self
        self.lazyTableView.dataSource = self
        self.view.addSubview(self.lazyTableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 2
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        if timeWhereWhatArray?.count != nil
        {
            return (timeWhereWhatArray?.count)!
        }
        else
        {
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if indexPath.row == 0
        {
            let cell = HRRecordsRecentlyTableViewCell(style: .default, reuseIdentifier: "middleCell")
            cell.accessoryType  = .disclosureIndicator
            cell.backgroundColor = UIColor(red: 224/255.0, green: 224/255.0, blue: 224/255.0, alpha: 1)
            
            if timeWhereWhatArray != nil
            {
                 cell.setUpUI(timeText: (timeWhereWhatArray![indexPath.section][0] as? String)!, hospitalTitle: (timeWhereWhatArray![indexPath.section][1] as? String)!, speciesTitle: (timeWhereWhatArray![indexPath.section][2] as? String)!)
            }
           
            cell.timeLable.textColor = .black
            cell.hospitalLabel.textColor = .black
            cell.speciesLabel.isHidden = true
            cell.selectionStyle = .none
            cell.hospitalLabel.textAlignment = .center
            return cell
            
        }
        else{
            
            let cell = HRRecordsImageTableViewCell(style: .default, reuseIdentifier: "imageCell")
            
            print(imageArray?.count ?? 0 )
            // ui
            if imageArray != nil
            {
                cell.setUpUI(imageURL: imageArray![indexPath.section] as NSArray)
            }
            cell.selectionStyle = .none
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if indexPath.row == 0
        {
            return 80/1135*HEIGHT
        }
        else
        {
            return 200/1135*HEIGHT
        }
        
    }
    
//    点击cell的方法
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if indexPath.row == 0
        {
//            let patientName = self.getThePatientName(objID: self.timeWhereWhatArray![indexPath.row][3] as! String)
            var patientName = ""
            
            let bmobObj: BmobQuery = BmobQuery(className: "homeGroup")
            bmobObj.getObjectInBackground(withId: self.timeWhereWhatArray![indexPath.row][3] as! String) { (obj, error) in
                if error != nil
                {
                    //                错误处理
                }
                else
                {
                    if obj != nil
                    {
                        patientName = (obj?.object(forKey: "patientName") as? String)!
                     
                        let vc = HRHomeBtnUploadViewController()
                        vc.hidesBottomBarWhenPushed = true
                        
                        vc.isNormalInput = false
                        vc.detailTextFiledText = self.timeWhereWhatArray![indexPath.row][5] as! String
                        vc.detailArr1 = [self.timeWhereWhatArray![indexPath.row][2],self.timeWhereWhatArray![indexPath.row][0]]
                        vc.detailArr2 = [patientName,self.timeWhereWhatArray![indexPath.row][1],self.timeWhereWhatArray![indexPath.row][4]]
                        vc.lazyTableView.reloadData()
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        
    }
    
}

