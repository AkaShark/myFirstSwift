//
//  HRPersonRecordsViewController.swift
//  HealthRecords
//
//  Created by kys-20 on 2018/4/23.
//  Copyright © 2018年 kys-20. All rights reserved.
//

import UIKit
import PagingMenuController
//分页菜单配置
public struct PresonPagingMenuOptions: PagingMenuControllerCustomizable
{
    
    public var isScrollEnabled: Bool
    public var defaultPage: Int
    
    //第1个子视图控制器
    let viewController1 = HRPersonRecordTableViewController()
    //第2个子视图控制器
    let viewController2 = HRPersonRecordTableViewController()
    let viewController3 = HRPersonRecordTableViewController()
    let viewController4 = HRPersonRecordTableViewController()
    let viewController5 = HRPersonRecordTableViewController()
    let viewController6 = HRPersonRecordTableViewController()
    let viewController7 = HRPersonRecordTableViewController()
    
    //组件类型
    public var componentType: ComponentType {
        return .all(menuOptions: MenuOptions(focusMode: .underline(height: 2, color: MainColor, horizontalPadding: 0, verticalPadding: 0)), pagingControllers: pagingControllers)
    }
    
    //所有子视图控制器
    public var pagingControllers: [UIViewController] {
        return [viewController1, viewController2,viewController3,viewController4,viewController5,viewController6,viewController7]
    }
    
    //菜单配置项
    public struct MenuOptions: MenuViewCustomizable {
        public var focusMode: MenuFocusMode
        
        //菜单显示模式
        public var displayMode: MenuDisplayMode {
            return .segmentedControl
        }
        //菜单项
        public var itemsOptions: [MenuItemViewCustomizable] {
            return [MenuItem1(), MenuItem2(),MenuItem3(),MenuItem4(),MenuItem5(),MenuItem6(),MenuItem7()]
        }
    }
    
    //    第一个菜单项
    public struct MenuItem1: MenuItemViewCustomizable{
        //        自定义菜单项名称
        public var displayMode: MenuItemDisplayMode{
            return .text(title: MenuItemText(text: "全部", color: StandGray, selectedColor: MainColor, font: thirdFont, selectedFont: thirdFont))
        }
    }
    
    public struct MenuItem2: MenuItemViewCustomizable{
        public var displayMode: MenuItemDisplayMode{
            return .text(title: MenuItemText(text: "检验", color: StandGray, selectedColor: MainColor, font: thirdFont, selectedFont: thirdFont))
        }
    }
    
    public struct MenuItem3: MenuItemViewCustomizable{
        public var displayMode: MenuItemDisplayMode{
            return .text(title: MenuItemText(text: "检查", color: StandGray, selectedColor: MainColor, font: thirdFont, selectedFont: thirdFont))
        }
    }
    
    public struct MenuItem4: MenuItemViewCustomizable{
        public var displayMode: MenuItemDisplayMode{
            return .text(title: MenuItemText(text: "体检", color: StandGray, selectedColor: MainColor, font: thirdFont, selectedFont: thirdFont))
        }
    }
    public struct MenuItem5: MenuItemViewCustomizable{
        public var displayMode: MenuItemDisplayMode{
            return .text(title: MenuItemText(text: "病历", color: StandGray, selectedColor: MainColor, font: thirdFont, selectedFont: thirdFont))
        }
    }
    public struct MenuItem6: MenuItemViewCustomizable{
        public var displayMode: MenuItemDisplayMode{
            return .text(title: MenuItemText(text: "处方", color: StandGray, selectedColor: MainColor, font: thirdFont, selectedFont: thirdFont))
        }
    }
    public struct MenuItem7: MenuItemViewCustomizable{
        public var displayMode: MenuItemDisplayMode{
            return .text(title: MenuItemText(text: "其他", color: StandGray, selectedColor: MainColor, font: thirdFont, selectedFont: thirdFont))
        }
    }
}

class HRPersonRecordsViewController: HRBaseViewController {
    
    
    var loadingView:LoadingView!
    
    //        //分页菜单配置
    var option = PresonPagingMenuOptions(isScrollEnabled: true, defaultPage: 5)
    
    var btnTitle: String = ""
    var index: Int?
    
    /// 数据数组 记得创建是要进行初始化(创建类型要： 声明但是没有初始化，= （ ）这样是进行初始化并声明 ！)
    var recordData = Array<Array<Any>>()
    var imageRcordArray = Array<Any>()
    
    
    var recordAllData = Array<Array<Any>>()
    var imageRcordAllArray = Array<Any>()
    
    override func viewWillAppear(_ animated: Bool)
    {
        self.navigationController?.navigationBar.isHidden = false
        
       
    }
    
    
    /// 获取数据
    func downLoadTheData(title:String) -> ()
    {
        
        self.showNoDataImage()
//        if title == "全部"
//        {
            //            请求全部信息
            let query: BmobQuery = BmobQuery(className: "medicinalRecord")
            query.findObjectsInBackground { (array, error) in
                if error != nil
                {
                    print(error!)
                }
                else
                {
                    print(array!)
                    //                获取数据
                    for i in 0..<array!.count
                    {
                        let obj = array![i] as! BmobObject
                        
                        let patientHospital = obj.object(forKey: "patientHospital")as? String ?? "没有数据"
                        let medicinalTime = obj.object(forKey: "medicinalTime") as? String ?? "没有数据"
                        let hospitalOffice = obj.object(forKey: "medicinalType") as? String ?? "没有数据"
                        let inspectionPictureURL = obj.object(forKey: "inspectionPictureURL") as? String ?? "没有数据"
                        let patientID = obj.object(forKey: "patientID") as? String ?? "没有数据"
                        let patientDepartment = obj.object(forKey: "hospitalOffice") as? String ?? "没有数据"
                        
                        let diseaseDescribe = obj.object(forKey: "diseaseDescribe") as? String ?? "没有数据"
                        
                        self.removeNoDataImage()
                        //                    处理数据
                        self.dealTheTimeAndReduceTheData(patientHospital: patientHospital, medicinalTime: medicinalTime, hospitalOffice: hospitalOffice, inspectionPictureURL: inspectionPictureURL,patientID:patientID,patientDepartment:patientDepartment,diseaseDescribe:diseaseDescribe)
                        
                        self.dealAllTheTimeAndReduceTheData(patientHospital: patientHospital, medicinalTime: medicinalTime, hospitalOffice: hospitalOffice, inspectionPictureURL: inspectionPictureURL,patientID:patientID,patientDepartment:patientDepartment,diseaseDescribe:diseaseDescribe)
                    }
                }
            }
            
            //        MARK:- 设置各个vc的数据
            //        }
            //        else
            //        {
            ////            请求对应的信息传递 这个就是根据title来说的
            //        }
//        }
        
    }
    
//    全部的
     func dealAllTheTimeAndReduceTheData(patientHospital: String, medicinalTime: String, hospitalOffice: String, inspectionPictureURL: String,patientID:String,patientDepartment:String,diseaseDescribe:String) -> ()
     {
     
        let timeWhereWhatArray = [medicinalTime,patientHospital,hospitalOffice,patientID,patientDepartment,diseaseDescribe]
        recordAllData.append(timeWhereWhatArray)
        
        if inspectionPictureURL.contains(",")
        {
            
            /// 分割 以逗号 ["",""]
            let imageArray = inspectionPictureURL.components(separatedBy: ",")
            imageRcordAllArray.append(imageArray)
        }
        else
        {
            //            添加以  []  Array<Array<Any>>
            imageRcordAllArray.append([inspectionPictureURL])
        }
        
        //        设置全部信息的方法
        option.viewController1.giveTheHealthRecords(data: self.recordAllData, imageData: self.imageRcordAllArray as! Array<Array<Any>>)
    }
    
    ///整理数据 重复抽成方法 每个
    func dealTheTimeAndReduceTheData(patientHospital: String, medicinalTime: String, hospitalOffice: String, inspectionPictureURL: String,patientID:String,patientDepartment:String,diseaseDescribe:String) -> ()
    {
//        设置每个信息
        if hospitalOffice == "检验"
        {
             let timeWhereWhatArray = [medicinalTime,patientHospital,hospitalOffice,patientID,patientDepartment,diseaseDescribe]
            recordData.append(timeWhereWhatArray)
            if inspectionPictureURL.contains(",")
            {
                
                /// 分割 以逗号 ["",""]
                let imageArray = inspectionPictureURL.components(separatedBy: ",")
                imageRcordArray.append(imageArray)
            }
            else
            {
                //            添加以  []  Array<Array<Any>>
                imageRcordArray.append([inspectionPictureURL])
            }
          option.viewController2.giveTheHealthRecords(data: self.recordData, imageData: self.imageRcordArray as! Array<Array<Any>>)
            self.recordData.removeAll()
            self.imageRcordArray.removeAll()
        }
        if hospitalOffice == "检查"
        {
             let timeWhereWhatArray = [medicinalTime,patientHospital,hospitalOffice,patientID,patientDepartment,diseaseDescribe]
            recordData.append(timeWhereWhatArray)
            if inspectionPictureURL.contains(",")
            {
                
                /// 分割 以逗号 ["",""]
                let imageArray = inspectionPictureURL.components(separatedBy: ",")
                imageRcordArray.append(imageArray)
            }
            else
            {
                //            添加以  []  Array<Array<Any>>
                imageRcordArray.append([inspectionPictureURL])
            }
            option.viewController3.giveTheHealthRecords(data: self.recordData, imageData: self.imageRcordArray as! Array<Array<Any>>)
            self.recordData.removeAll()
            self.imageRcordArray.removeAll()
        }
        if hospitalOffice == "体检"
        {
             let timeWhereWhatArray = [medicinalTime,patientHospital,hospitalOffice,patientID,patientDepartment,diseaseDescribe]
            recordData.append(timeWhereWhatArray)
            if inspectionPictureURL.contains(",")
            {
                
                /// 分割 以逗号 ["",""]
                let imageArray = inspectionPictureURL.components(separatedBy: ",")
                imageRcordArray.append(imageArray)
            }
            else
            {
                //            添加以  []  Array<Array<Any>>
                imageRcordArray.append([inspectionPictureURL])
            }
            option.viewController4.giveTheHealthRecords(data: self.recordData, imageData: self.imageRcordArray as! Array<Array<Any>>)
            self.recordData.removeAll()
            self.imageRcordArray.removeAll()
        }
        if hospitalOffice == "病历"
        {
             let timeWhereWhatArray = [medicinalTime,patientHospital,hospitalOffice,patientID,patientDepartment,diseaseDescribe]
            recordData.append(timeWhereWhatArray)
            if inspectionPictureURL.contains(",")
            {
                
                /// 分割 以逗号 ["",""]
                let imageArray = inspectionPictureURL.components(separatedBy: ",")
                imageRcordArray.append(imageArray)
            }
            else
            {
                //            添加以  []  Array<Array<Any>>
                imageRcordArray.append([inspectionPictureURL])
            }
            option.viewController5.giveTheHealthRecords(data: self.recordData, imageData: self.imageRcordArray as! Array<Array<Any>>)
            self.recordData.removeAll()
            self.imageRcordArray.removeAll()
        }
        if hospitalOffice == "处方"
        {
             let timeWhereWhatArray = [medicinalTime,patientHospital,hospitalOffice,patientID,patientDepartment,diseaseDescribe]
            recordData.append(timeWhereWhatArray)
            if inspectionPictureURL.contains(",")
            {
                
                /// 分割 以逗号 ["",""]
                let imageArray = inspectionPictureURL.components(separatedBy: ",")
                imageRcordArray.append(imageArray)
            }
            else
            {
                //            添加以  []  Array<Array<Any>>
                imageRcordArray.append([inspectionPictureURL])
            }
            option.viewController6.giveTheHealthRecords(data: self.recordData, imageData: self.imageRcordArray as! Array<Array<Any>>)
            self.recordData.removeAll()
            self.imageRcordArray.removeAll()
        }
        
     
        
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.setIsShowLiftBakc(ShowLiftBack: true)
        downLoadTheData(title: btnTitle)
        
        
        let share = UIButton(type: .custom)
        share.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        share.addTarget(self, action: #selector(shareTheAllRecord), for: .touchUpInside)
        share.setImage(UIImage(named: "分享-3"), for: .normal)
        let shareItem = UIBarButtonItem(customView: share)
        
        
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        btn.addTarget(self, action: #selector(addTheRecord), for: .touchUpInside)
        btn.setImage(UIImage(named: "添加-5"), for: .normal)
        
        let btnitem = UIBarButtonItem(customView: btn)
        
        self.navigationItem.rightBarButtonItems = [btnitem,shareItem]
        
        
        
        let user = BmobUser.current()
        if user != nil {
            //进行操作 返回的手机号
                self.changeNavTitle(navTitleName: "查看健康档案")
            //
        }else{
            //对象为空时，可打开用户注册界面
            self.changeNavTitle(navTitleName: "就医记录")
        }
        
//        option.defaultPage = index ?? 0
        
        if self.btnTitle == ""
        {
            option.defaultPage = 0
        }
        else
        {
            option.defaultPage = self.judgeTheIndex(title: self.btnTitle)
        }
        
        
        
        
        //        设置菜单controller
        let pagingMenuController = PagingMenuController(options: option)
        addChildViewController(pagingMenuController)
        view.addSubview(pagingMenuController.view)
        
    }
//判断返回哪一个index
    func judgeTheIndex(title: String) -> Int
    {
        if title == "全部"
        {
            return 0
        }
        else if title == "体检报告"
        {
            return 3
        }
        else if title == "检验报告"
        {
            return 1
        }
        else if title == "检查报告"
        {
            return 2
        }
        else if title == "病历"
        {
            return 4
        }
        else
        {
            return 5
        }
        
    }
    
    
    @objc func shareTheAllRecord ()
    {
        
        UMSocialSwiftInterface.setPreDefinePlatforms([
            (UMSocialPlatformType.wechatSession.rawValue),
            (UMSocialPlatformType.wechatTimeLine.rawValue),
            (UMSocialPlatformType.QQ.rawValue),
            (UMSocialPlatformType.qzone.rawValue)
            ])
        
        UMSocialUIManager.removeAllCustomPlatformWithoutFilted()
        UMSocialShareUIConfig.shareInstance().sharePageGroupViewConfig.sharePageGroupViewPostionType = UMSocialSharePageGroupViewPositionType.middle
        UMSocialShareUIConfig.shareInstance().sharePageScrollViewConfig.shareScrollViewPageItemStyleType = UMSocialPlatformItemViewBackgroudType.none
        
        UMSocialSwiftInterface.showShareMenuViewInWindowWithPlatformSelectionBlock { (platformType, userInfo) in
            self.runShareWithType(type: platformType)
        }
    }
    
    func runShareWithType(type:UMSocialPlatformType) -> Void {
        print("runShareWithType-----\(type)")
        
        let messageObject = UMSocialMessageObject.init()
//       分享的文字之类的信息
        messageObject.text = "终于搞定了，😄\n欢迎使用【友盟+】社会化组件U-Share，SDK包最小，集成成本最低，助力您的产品开发、运营与推广！"
        UMSocialSwiftInterface.share(plattype: type, messageObject: messageObject, viewController: self) { (data, error) in
            if (error != nil) {
                
            }else{
                
            }
        }
    }
    
    @objc func addTheRecord()
    {
        let vc = HRHomeBtnUploadViewController()
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //    动画
    override func showNoDataImage() {
        let loadingView = LoadingView.showLoadingWith(view: view)
        self.loadingView = loadingView
    }
    
    override func removeNoDataImage()
    {
        loadingView.hideLoadingView()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

