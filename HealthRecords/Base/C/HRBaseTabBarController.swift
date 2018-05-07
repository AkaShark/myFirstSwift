//
//  HRBaseTabBarController.swift
//  HealthRecords
//
//  Created by kys-20 on 2018/4/14.
//  Copyright © 2018年 kys-20. All rights reserved.
//

import UIKit

class HRBaseTabBarController: AnimationTabBarController,UITabBarControllerDelegate
{
    
    fileprivate var firstLoadMainTabBarController: Bool = true
    fileprivate var adImageView: UIImageView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        uitabbarControllerDelegate
        delegate = self
        //      tabbarcontroller
        createMainTabBarChildViewController()
        creatTheLineColor(MainColor)
        // Do any additional setup after loading the view.
    }
    
    func creatTheLineColor(_ color: UIColor) -> () {
        let size = CGSize(width: WIDTH, height: 0.5)
        let image = UIColor.createImage(color: color, size: size)
        self.tabBar.shadowImage = image
        let backImage = UIColor.createImage(color: .white, size: CGSize(width: WIDTH, height:49))
        self.tabBar.backgroundImage = backImage
    }
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if firstLoadMainTabBarController {
            let containers = createViewContainers()
            
            createCustomIcons(containers)
            firstLoadMainTabBarController = false
        }
    }
    
    //    MARK:- 初始化tabbar
    fileprivate func createMainTabBarChildViewController()
    {
        //MARK:- 问题~~~
        //        这个有问题除了在这写下还要在里面在写下！！！！
        tabBarControllerAddChildViewController(HRHomeViewController(), title: "首页", imageName: "首页", SelectedImageName: "首页-2", tag: 0)
        
        tabBarControllerAddChildViewController(HRRecordsViewController(), title: "健康档案", imageName: "工作档案", SelectedImageName: "工作档案-2", tag: 1)
        tabBarControllerAddChildViewController(HRInformationViewController(), title: "资讯", imageName: "资讯", SelectedImageName: "资讯-2", tag: 2)
        tabBarControllerAddChildViewController(HRMyInformationTableViewController(), title: "我的", imageName: "我的", SelectedImageName: "我的-2", tag: 3)
        
    }
    
    fileprivate func tabBarControllerAddChildViewController(_ childView: UIViewController, title: String, imageName: String, SelectedImageName:String,tag: Int)
    {
        let vcItem = RAMAnimatedTabBarItem(title: title, image: UIImage(named: imageName), selectedImage: UIImage(named: SelectedImageName))
        vcItem.tag = tag
        //        设置动画效果
        //        if tag == 0 {
        //            vcItem.animation = RAMBounceAnimation()
        //        }
        //        if tag == 1 {
        //             vcItem.animation = RAMRotationAnimation()
        //        }
        //        if tag == 2
        //        {
        //            vcItem.animation = RAMBounceAnimation()
        ////        }
        //        let animation = RAMFrameItemAnimation()
        //        animation.imagesPath = "ToolsAnimation"
        //        vcItem.animation = animation
        
        vcItem.animation = RAMBounceAnimation()
        childView.tabBarItem = vcItem
        
        
        let navigationVC = HRBaseNavigationController(rootViewController: childView)
        addChildViewController(navigationVC)
        
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        let childArr = tabBarController.childViewControllers as NSArray
        let index = childArr.index(of: viewController)
        if index == 2 {
            return false
        }
        return true
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

