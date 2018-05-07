//
//  AnimationTabBarController.swift
//  HealthRecords
//
//  Created by kys-20 on 2018/4/14.
//  Copyright © 2018年 kys-20. All rights reserved.
//

import UIKit

protocol RAMItemAnimationProtocol {
    func playAnimation(_ icon: UIImageView,textLabel:UILabel)
    func deselectAnimation(_ icon: UIImageView,textLabel: UILabel,defaultTextColor: UIColor)
    func selectedState(_ icon: UIImageView,textLabel: UILabel)
}


class RAMItemAnimation: NSObject,RAMItemAnimationProtocol {
    var duration: CGFloat = 0.6
//    设置选中颜色
    var textSelectedColor: UIColor = MainColor
    var iconSelectedColor: UIColor?
    
    func playAnimation(_ icon: UIImageView, textLabel: UILabel) {
        
    }
    
    func deselectAnimation(_ icon: UIImageView, textLabel: UILabel, defaultTextColor: UIColor) {
        
    }
    
    func selectedState(_ icon: UIImageView, textLabel: UILabel) {
        
    }
    
}

class RAMBounceAnimation: RAMItemAnimation {
    override func playAnimation(_ icon: UIImageView, textLabel: UILabel) {
        playBounceAnimation(icon)
        textLabel.textColor = textSelectedColor
    }
    
    override func deselectAnimation(_ icon: UIImageView, textLabel: UILabel, defaultTextColor: UIColor) {
        
        textLabel.textColor = defaultTextColor
        
        if let iconImage = icon.image{
            let renderImage = iconImage.withRenderingMode(.alwaysOriginal)
            icon.image = renderImage
            icon.tintColor = defaultTextColor
        }
    }
    
    override func selectedState(_ icon: UIImageView, textLabel: UILabel)
    {
        
        textLabel.textColor = textSelectedColor
        if let iconImage = icon.image
        {
            let renderImage = iconImage.withRenderingMode(.alwaysOriginal)
            icon.image = renderImage
            icon.tintColor = textSelectedColor
        }
    }
    
    func playBounceAnimation(_ icon: UIImageView)
    {
        let bounceAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        bounceAnimation.values = [1.0, 1.4, 0.9, 1.15, 0.95, 1.02, 1.0]
        bounceAnimation.duration = TimeInterval(duration)
        bounceAnimation.calculationMode = kCAAnimationCubic
        
        icon.layer.add(bounceAnimation, forKey: "bounceAnimation")
        
        if let iconImage = icon.image {
            let renderImage = iconImage.withRenderingMode(.alwaysOriginal)
            icon.image = renderImage
            icon.tintColor = iconSelectedColor
        }
    }
}

/// 动画 从写了UItabBarItem增加了动画的方法
class RAMAnimatedTabBarItem: UITabBarItem {
    var animation: RAMItemAnimation?
    var textColor = UIColor.gray
    
    func playAnimation(_ icon:UIImageView,textLabel:UILabel)  {
        guard let animation = animation  else {
            print("add animation in UITabBarItem")
            return
        }
        animation.playAnimation(icon, textLabel: textLabel)
    }
    
    func deselectAnimation(_ icon: UIImageView, textLabel: UILabel)  {
        animation?.deselectAnimation(icon, textLabel: textLabel, defaultTextColor: textColor)
    }
    
    func selectedState(_ icon: UIImageView,textLabel: UILabel){
        animation?.selectedState(icon, textLabel: textLabel)
    }
}

class AnimationTabBarController: UITabBarController {
    
    var iconsView: [(icon: UIImageView,textLabel: UILabel)] = []
    var iconsImageName:[String] = ["首页","工作档案","资讯","我的"]
    var iconsSelectedImageName: [String] = ["首页-2","工作档案-2","资讯-2","我的-2"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    //    创建承载TabBarItem的视图容器，里面是item中的titleLabel和UIImageView，将视图容器存入字典，以便在后续中使用可以分清是点了哪一个item
    
    
    //    创建view容器
    func createViewContainers() -> [String:UIView]
    {
        var containersDict = [String: UIView]()
        //        tabbar的item是继承的自定义的RAMAnimatedTabBarItem，其中包含了动画的设置的函数
        guard let customItems = tabBar.items as? [RAMAnimatedTabBarItem] else {
            return containersDict
        }
        
        //根据item的个数创建视图容器，将视图容器放在字典中
        for index in 0..<customItems.count {
            let viewContainer = createViewContainer(index)
            containersDict["container\(index)"] = viewContainer
        }
        return containersDict
    }
    //    根据index值创建每一个的视图容器
    func createViewContainer(_ index:Int) -> UIView {
        let viewWidth: CGFloat = WIDTH / CGFloat(tabBar.items!.count)
        let viewHeight: CGFloat = tabBar.height
        let viewContainer = UIView(frame: CGRect(x: viewWidth*CGFloat(index), y: 0, width: viewWidth, height: viewHeight))
        
        viewContainer.backgroundColor = UIColor.clear
        viewContainer.isUserInteractionEnabled  = true
        tabBar.addSubview(viewContainer)
        viewContainer.tag = index
        //给容器添加手势，其实是自己重写了系统的item的功能，应为我们在里面加入动画
        let tap = UITapGestureRecognizer(target: self, action: Selector("tabBarClick:"))
        viewContainer.addGestureRecognizer(tap)
        return viewContainer
    }
    
    
    //    创建items的具体内容
    func createCustomIcons(_ containers: [String:UIView])
    {
        if let items = tabBar.items{
            for (index,item) in items.enumerated()
            {
                assert(item.image != nil,"add image icon in UITabBarItem")
                guard let container = containers["container\(index)"]
                    else
                {
                    print("NO contaniner given")
                    continue
                }
                container.tag = index
                let imageW :CGFloat = 21
                let imageX :CGFloat = (WIDTH / CGFloat(items.count) - imageW) * 0.5
                let imageY: CGFloat = 8
                let imageH: CGFloat = 21
                let icon = UIImageView(frame: CGRect(x: imageX, y: imageY, width: imageW, height: imageH))
                icon.image  = item.image
                icon.tintColor = UIColor.clear
                
                let textLabel = UILabel()
                textLabel.frame = CGRect(x: 0, y: 32, width: WIDTH/CGFloat(items.count), height: 17)
                textLabel.text = item.title
                textLabel.backgroundColor = .clear
                textLabel.font = UIFont.systemFont(ofSize: 10)
                textLabel.textAlignment = .center
//                设置未选中颜色
                textLabel.textColor = .gray
//                textLabel.translatesAutoresizingMaskIntoConstraints = false
                container.addSubview(icon)
                container.addSubview(textLabel)
                
                if let tabBarItem = tabBar.items
                {
                    let textLabelWidth = tabBar.frame.size.width/CGFloat(tabBarItem.count)
                    textLabel.bounds.size.width = textLabelWidth
                }
                let iconsAndLabels = (icon:icon,textLabel:textLabel)
                iconsView.append(iconsAndLabels)
                
                item.image = nil
                item.title = ""
                
                if index == 0
                {
                    selectedIndex = 0
                    selectItem(0)
                }
            }
        }
    }
    
//    重写父类的didSelectItem  这个方法就是已经选择了对应的item调用的方法
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
         setSelectIndex(from: selectedIndex, to: item.tag)
    }
    
//    选择item是item中内容的变化
    func selectItem(_ index:Int) -> () {
        let items = tabBar.items as! [RAMAnimatedTabBarItem]
        let selectIcon = iconsView[index].icon
        selectIcon.image = UIImage(named: iconsSelectedImageName[index])
        items[index].selectedState(selectIcon, textLabel: iconsView[index].textLabel)
    }
    
//    根据选择的index值设置item中的内容并且执行动画父类中的方法
  func setSelectIndex(from: Int,to: Int) -> () {
        selectedIndex = to
        let items = tabBar.items as! [RAMAnimatedTabBarItem]
        let fromIV = iconsView[from].icon
        fromIV.image = UIImage(named: iconsImageName[from])
        items[from].deselectAnimation(fromIV, textLabel: iconsView[from].textLabel)
        
        let toIV = iconsView[to].icon
        toIV.image = UIImage(named: iconsSelectedImageName[to])
        items[to].playAnimation(toIV, textLabel: iconsView[to].textLabel)
    }
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

