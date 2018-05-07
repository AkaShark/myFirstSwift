//
//  HRBaseViewController.swift
//  HealthRecords
//
//  Created by kys-20 on 2018/4/9.
//  Copyright © 2018年 kys-20. All rights reserved.
//

import UIKit
import MJRefresh
@objc
class HRBaseViewController: UIViewController {
    
    
    /// 状态栏
//    var statusBarStyle: UIStatusBarStyle?
    
    /// 无数据时的展位图
    var _noDataView: UIImageView?
    
    
    /// 是否显示返回按钮
    var isShowLiftBakc: Bool?
    
    /// 是否隐藏导航栏
    var isHidenNavBar:Bool?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = MainBackGroundColor
//        self.edgesForExtendedLayout = []
        self.isShowLiftBakc = true
    }
    
//    func preferredStatusBarStyle() -> UIStatusBarStyle {
//        return statusBarStyle!
//    }
    
    /// 动态更新状态栏颜色
    ///
    /// - Parameter statusBarStyle: 返回状态栏
//    func setStatusBarStyle(StatusBarStyle: UIStatusBarStyle) -> ()
//    {
//        statusBarStyle = StatusBarStyle
//        self.setNeedsStatusBarAppearanceUpdate()
//    }
    
    ///
    ///
    /// - Parameter navTitleName: 导航栏标题 not both 
    func changeNavTitle(navTitleName: String)
    {
        self.navigationItem.title = navTitleName
    }

    //    MARK:-设置展位图
    
    ///设置没有数据时的展位图
    func showNoDataImage() -> () {
        _noDataView = UIImageView()
        _noDataView?.image = UIImage(named:"空的没数据的展位图")
        
    }
    /// 移除展位图
    func removeNoDataImage() -> () {
        if (_noDataView != nil)
        {
            _noDataView?.removeFromSuperview()
            _noDataView = nil
        }
    }
    
    //    MARK:-加载动画和取消
    /// 加载动画
    func showLoadingAnimation() -> ()
    {
        
    }
    
    /// 定制加载(动画)
    func stopLoadingAnimation() -> ()
    {
        
    }
    
    
    
    //    MARK:- 是否显示返回按钮
    
    /// 方法是否显示返回按钮
    ///
    /// - Parameter ShowLiftBack: 是否
    func setIsShowLiftBakc(ShowLiftBack: Bool) -> () {
        isShowLiftBakc = ShowLiftBack
        let VCCoutn = self.navigationController?.viewControllers.count
        //下面判断的意义是 当VC所在的导航控制器中的VC个数大于1或者是 present出来是才展示返回按钮其他不展示
        if ShowLiftBack && (VCCoutn! > 1 || self.navigationController?.presentedViewController != nil) {
            self.addNavigtionItemWithImageNames(imagesNames: ["返回-3"], isLeft: true, target: self, action: #selector(backBtnClicked), tags:[])
            
        }
        else
        {
            self.navigationItem.hidesBackButton = true
            let NULLBar = UIBarButtonItem(customView: UIView())
            self.navigationItem.leftBarButtonItem = NULLBar
        }
        
    }
    
    ///点击返回按钮
    @objc func backBtnClicked()
    {
        if (self.presentingViewController != nil)
        {
            self.dismiss(animated: true, completion: nil)
        }
        else
        {
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    //    MARK:- 导航栏 添加文字按钮和文字按钮
    
    /// 设置导航栏文字btn
    ///
    /// - Parameters:
    ///   - titles: 标题数组
    ///   - isLeft: 是否在左边
    ///   - target: 目标
    ///   - action: 事件
    ///   - tags: 用与区分
    func addNavigationItemWithTitles(titles:[String],isLeft: Bool,target: Any,action: Selector,tags:[Int]) -> ()
    {
        let items = NSMutableArray()
        let buttonArray = NSMutableArray()
        var i = 0
        for title in titles {
            let btn = UIButton(type: .custom)
            btn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            btn.setTitle(title, for: .normal)
            btn.addTarget(target, action: action, for: .touchUpInside)
            btn.titleLabel?.font = secondFont
            btn.setTitleColor(.black, for: .normal)
            i += 1
//            btn.tag = tags[i]
            btn.sizeToFit()
            
            //          设置偏移
            if isLeft
            {
                btn.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 10)
            }
            else
            {
                btn.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, -10)
            }
            
            let item = UIBarButtonItem(customView: btn)
            items.add(item)
            buttonArray.add(btn)
            
        }
        if isLeft
        {
            self.navigationItem.leftBarButtonItems = items as? [UIBarButtonItem]
        }
        else
        {
            self.navigationItem.rightBarButtonItems = items as? [UIBarButtonItem]
        }
        
        
    }
    
    
    
    /// 导航栏添加图标按钮
    ///
    /// - Parameters:
    ///   - imagesNames: 图标数组
    ///   - isLeft: 是否是左边 非左即右
    ///   - target: 目标
    ///   - action: 点击方法
    ///   - tags: tags数组 回调分区用
    func addNavigtionItemWithImageNames(imagesNames:Array<Any>,isLeft: Bool, target:Any,action:Selector,tags:Array<Any>) -> () {
        let items = NSMutableArray()
        var i = 0
        for imageName in imagesNames {
            let btn = UIButton(type: .custom)
            btn.setImage(UIImage(named: imageName as! String), for: .normal)
            btn.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
            btn.addTarget(target, action: action, for: .touchUpInside)
            
            if isLeft
            {
                btn.contentEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 10)
            }
            else
            {
                btn.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, -10)
            }
            i += 1
//            btn.tag = tags[i]
            let item = UIBarButtonItem(customView: btn)
            items.add(item)
            
        }
        if isLeft
        {
            self.navigationItem.leftBarButtonItems = items as? [UIBarButtonItem]
        }
        else{
            self.navigationItem.rightBarButtonItems = items as? [UIBarButtonItem]
        }
        
    }
    
    //    MARK:-  懒加载tableVIew和collectionView
    
    /// 懒加载tableVIew
    lazy var lazyTableView: UITableView = {
        
    
//        设置tableVIew太高了 设置为高度
        let tempTableView = UITableView(frame: CGRect(x: 0, y: 0, width: Int(WIDTH), height: Int(HEIGHT) - 80), style: .plain)
        tempTableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        tempTableView.estimatedRowHeight = 0
        tempTableView.estimatedSectionFooterHeight = 0
        tempTableView.estimatedSectionHeaderHeight = 0
        
        let header = QXRefreshHeader(refreshingBlock: {
            
            self.headerRereshing()
        })
        tempTableView.mj_header = header
//        tempTableView.mj_header.beginRefreshing()
//        QXRefreshHeader *header = [QXRefreshHeader headerWithRefreshingBlock:^{
//            [weakSelf loadData];
//            }];
//        _mTableView.mj_header = header;
//        [_mTableView.mj_header beginRefreshing];
        
        
//        //底部刷新
//        tempTableView.mj_footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(footerRereshing))
        
        
        tempTableView.backgroundColor = MainBackGroundColor
        tempTableView.scrollsToTop = true
        
        return tempTableView
    }()
    
    
    
    
    
    /// 懒加载collectionView
    lazy var lazyCollectionView: UICollectionView = {
        
        let flow = UICollectionViewFlowLayout()
        let tempCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: WIDTH, height: HEIGHT), collectionViewLayout: flow)
        
        //头部刷新
        let header  = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(headerRereshing))
        
        header?.isAutomaticallyChangeAlpha = true
        header?.lastUpdatedTimeLabel.isHidden = true
        tempCollectionView.mj_header = header
        
        tempCollectionView.mj_footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(footerRereshing))
        
        
        tempCollectionView.backgroundColor = StandColor
        tempCollectionView.scrollsToTop = true
        
        
        
        return tempCollectionView
        
    }()
    
    
    /// 头部刷新方法
    @objc func headerRereshing ()
    {
        
    }
    
    /// 底部刷新方法
    @objc func footerRereshing()
    {
        
    }
    
    /// 隐藏动画
    ///
    /// - Parameter view: 传入的view
    public func hidden(view: UIView)
    {
        let animation = CATransition()
        animation.type = kCATransitionFade
        animation.duration = 0.4
        view.layer.add(animation, forKey: nil)
        view.isHidden = false
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}

extension HRBaseViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        // return TKFadeInAnimator(transitionDuration: 0.5, startingAlpha: 0.8)
        return nil
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
}

