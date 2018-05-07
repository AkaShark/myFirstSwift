//
//  HRHomeMiddleTableViewCell.swift
//  HealthRecords
//
//  Created by kys-20 on 2018/4/17.
//  Copyright © 2018年 kys-20. All rights reserved.
//

import UIKit

/// 开始没有想到复用性啊 。。。
class HRHomeMiddleTableViewCell: UITableViewCell {

    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 最初的构造方法
    ///
    /// - Parameter imageName:
    func setUpUI(imageName:String) -> ()
    {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: WIDTH, height: 50))
        image.image = UIImage(named: imageName)
        self.addSubview(image)
    }
    
    /// 忘记为啥了
    ///
    /// - Parameter imageName:
    func setUpUI1(imageName: String) -> ()
    {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: WIDTH, height: 800/2205*HEIGHT))
        image.image = UIImage(named: imageName)
        self.addSubview(image)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
