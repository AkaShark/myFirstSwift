//
//  HRHomeHeadVIew.swift
//  HealthRecords
//
//  Created by kys-20 on 2018/4/17.
//  Copyright © 2018年 kys-20. All rights reserved.
//

import UIKit
import SDCycleScrollView
import SnapKit

protocol homeBtnClickDelegate
{
    func homeBtnClickDelegate(index: Int)
}

class HRHomeHeadVIew: UIView,SDCycleScrollViewDelegate
{
    private let cycleScrollerView = SDCycleScrollView()
    private var headBtnArray:Array<HRHomeBtn>?
    
    var delegate: homeBtnClickDelegate?
    
    
    init(frame: CGRect,imageArray:Array<String>,titleName:Array<String>)
    {
        super.init(frame: frame)
        setTheUI(imageArray: imageArray, titleName: titleName)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setTheUI(imageArray:Array<String>,titleName:Array<String>)
    {
       
//       添加滚动条
        cycleScrollerView.frame = CGRect(x: 0, y: 0, width: WIDTH, height: 254/455*self.height)
//        展位图
        cycleScrollerView.placeholderImage = UIImage()
        cycleScrollerView.titlesGroup = titleName
        cycleScrollerView.titleLabelHeight = 40
        cycleScrollerView.titleLabelBackgroundColor = .clear
        cycleScrollerView.titleLabelTextColor = .white
        cycleScrollerView.delegate = self
        cycleScrollerView.imageURLStringsGroup = imageArray
        cycleScrollerView.autoScroll = true
        cycleScrollerView.infiniteLoop  = true
        cycleScrollerView.pageControlDotSize = CGSize(width: 20, height: 20)
        cycleScrollerView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight
//        cycleScrollerView.currentPageDotColor = .red
//        cycleScrollerView.pageDotColor = .black
//        下标小图
        cycleScrollerView.currentPageDotImage = UIImage(named: "选中1")
        cycleScrollerView.pageDotImage = UIImage(named: "未选中1")
        self.addSubview(cycleScrollerView)
        
        
        for i in 0..<3 {
            
//            let head = HRHomeBtn(frame: CGRect(x: CGFloat(Float(i))*WIDTH/3, y: 250/450*self.height, width: WIDTH/3, height: 200/450*self.height), imageName: ["钥匙"], titleName: ["报告单","健康档案","就医记录"])
            let head = HRHomeBtn(frame: CGRect(x: CGFloat(Float(i))*WIDTH/3, y: 250/450*self.height, width: WIDTH/3, height: 200/450*self.height), imageName: ["上传报告单1","就医记录1","健康档案1"], titleName: ["上传报告单","就医记录","健康档案"], i: i)
            for button in head.subviews
            {
                if button is JXLayoutButton
                {
                    let jxButton = button as! JXLayoutButton
                    jxButton.tag = i
                    jxButton.addTarget(self, action: #selector(touchTheBtnToRecord(_:)), for: .touchUpInside)
                }
            }
            
            self.addSubview(head)
        }
    }
    
    /// 点击事件
    @objc func touchTheBtnToRecord(_ button:JXLayoutButton) -> ()
    {
        self.delegate?.homeBtnClickDelegate(index: button.tag)
    }
    
    
}
