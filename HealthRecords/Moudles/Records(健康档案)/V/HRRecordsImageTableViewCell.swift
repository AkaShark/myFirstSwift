//
//  HRRecordsImageTableViewCell.swift
//  HealthRecords
//
//  Created by kys-20 on 2018/4/23.
//  Copyright © 2018年 kys-20. All rights reserved.
//

import UIKit

class HRRecordsImageTableViewCell: UITableViewCell,SDPhotoBrowserDelegate {
    
    
  
    
    
    var imageArray:Array<Any>?
    var imageViewArray = Array<Any>()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setUpUI(imageURL: NSArray) -> ()
    {
        self.imageArray = imageURL as? Array<Any>
        
        for i in 0..<imageURL.count
        {
            let singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(imageClick(_:)))
            let margin = WIDTH/25
            let X = margin+(WIDTH/5+WIDTH/25)*CGFloat(i)
            let imageView = UIImageView(frame: CGRect(x: X, y: 15/1134*HEIGHT, width: WIDTH/5, height: WIDTH/4))
            imageView.tag = i
            imageView.addGestureRecognizer(singleTapGesture)
            imageView.isUserInteractionEnabled = true
            imageView.kf.setImage(with: URL(string: imageURL[i] as! String))
            self.imageViewArray.append(imageView)
            self.addSubview(imageView)
            
        }
    }
    
    /// 点击事件
    ///
    /// - Parameter tap:
    @objc func imageClick(_ tap: UITapGestureRecognizer) -> ()
    {
        let imageView = tap.view
        let browser = SDPhotoBrowser()
        browser.currentImageIndex = (imageView?.tag)!
//        在油茶中这个属性传的是“browser.sourceImagesContainerView = self.contentView;” 也是一个cell但是传入的父视图是contenView 但是在这里传入的是self 不知道为什么回来再去研究下 好像是有没有subviews 的原因
        browser.sourceImagesContainerView = self
        browser.imageCount = (self.imageArray?.count)!
        browser.delegate = self
        browser.show()
    }
    
    //MARK:- 图片浏览器的代理方法
    
    func photoBrowser(_ browser: SDPhotoBrowser!, placeholderImageFor index: Int) -> UIImage!
    {
        let imageView = self.imageViewArray[index] as! UIImageView
        return imageView.image
    }
//    展位图
    func photoBrowser(_ browser: SDPhotoBrowser!, highQualityImageURLFor index: Int) -> URL!
    {
        let imageName = self.imageArray![index] as! String
        let url = URL(string: imageName)
        return url
    }
    
}

