//
//  HRInformationViewController.swift
//  HealthRecords
//
//  Created by kys-20 on 2018/4/21.
//  Copyright © 2018年 kys-20. All rights reserved.
//

import UIKit
import PagingMenuController

//分页菜单配置
public struct PagingMenuOptions: PagingMenuControllerCustomizable {
    public var isScrollEnabled: Bool
    
    public var defaultPage: Int
    
    //第1个子视图控制器
    let viewController1 = HRDataViewController()
    //第2个子视图控制器
    let viewController2 = HRDataViewController()
    let viewController3 = HRDataViewController()
    let viewController4 = HRDataViewController()
    let viewController5 = HRDataViewController()
    
    //组件类型
    public var componentType: ComponentType {
        return .all(menuOptions: MenuOptions(focusMode: .underline(height: 2, color: MainColor, horizontalPadding: 0, verticalPadding: 0)), pagingControllers: pagingControllers)
    }
    
    //所有子视图控制器
    public var pagingControllers: [UIViewController] {
        return [viewController1, viewController2,viewController3,viewController4,viewController5]
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
            return [MenuItem1(), MenuItem2(),MenuItem3(),MenuItem4(),MenuItem5()]
        }
    }
    
    //    第一个菜单项
    public struct MenuItem1: MenuItemViewCustomizable{
        //        自定义菜单项名称
        public var displayMode: MenuItemDisplayMode{
            return .text(title: MenuItemText(text: "热点", color: StandGray, selectedColor: MainColor, font: thirdFont, selectedFont: thirdFont))
        }
    }
    
    public struct MenuItem2: MenuItemViewCustomizable{
        public var displayMode: MenuItemDisplayMode{
            return .text(title: MenuItemText(text: "常识", color: StandGray, selectedColor: MainColor, font: thirdFont, selectedFont: thirdFont))
        }
    }
    
    public struct MenuItem3: MenuItemViewCustomizable{
        public var displayMode: MenuItemDisplayMode{
            return .text(title: MenuItemText(text: "养生", color: StandGray, selectedColor: MainColor, font: thirdFont, selectedFont: thirdFont))
        }
    }
    
    public struct MenuItem4: MenuItemViewCustomizable{
        public var displayMode: MenuItemDisplayMode{
            return .text(title: MenuItemText(text: "生活焦点", color: StandGray, selectedColor: MainColor, font: thirdFont, selectedFont: thirdFont))
        }
    }
    public struct MenuItem5: MenuItemViewCustomizable{
        public var displayMode: MenuItemDisplayMode{
            return .text(title: MenuItemText(text: "猜你想看", color: StandGray, selectedColor: MainColor, font: thirdFont, selectedFont: thirdFont))
        }
    }
}


class HRInformationViewController: HRBaseViewController {
    
    
    var loadingView:LoadingView!
    
    var dataModel = HRInformationModel()
    //分页菜单配置
    var options = PagingMenuOptions(isScrollEnabled: true, defaultPage: 0)
    
    override func viewWillAppear(_ animated: Bool)
    {
        
        //        无数据
        self.DownLoadData()
    }
    
    func DownLoadData() -> Void
    {
         self.showNoDataImage()
        HttpTool.getRequest("http://60.205.228.179/HR/show.php", success: { (dic) in
            
            if let dataModel = HRInformationModel.deserialize(from: dic){
                self.dataModel = dataModel
                
                if self.dataModel.result != nil
                {
//                    进行数组的切片操作后强转为数组类型 result![0..<15] 数组切片 
                    self.options.viewController1.giveTheData(data:Array(self.dataModel.result![0..<15]))
                    self.options.viewController2.giveTheData(data:Array(self.dataModel.result![15..<30]))
                    self.options.viewController3.giveTheData(data:Array(self.dataModel.result![60..<75]))
                    self.options.viewController4.giveTheData(data:Array(self.dataModel.result![30..<45]))
                    self.options.viewController5.giveTheData(data:Array(self.dataModel.result![45..<60]))
                }
                
                //            有数据是取出无数据图
                            self.removeNoDataImage()
            }
        }) { (error) in
            print("失败\(error)")
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
       
        
        self.changeNavTitle(navTitleName: "资讯")
        
        //分页菜单控制器初始化
        let pagingMenuController = PagingMenuController(options: options)
        //       建立父子关系
        addChildViewController(pagingMenuController)
        view.addSubview(pagingMenuController.view)
        // Do any additional setup after loading the view.
    }
    
    
//    动画
    override func showNoDataImage() {
        let loadingView = LoadingView.showLoadingWith(view: view)
        self.loadingView = loadingView
    }
    override func removeNoDataImage() {
         loadingView.hideLoadingView()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

