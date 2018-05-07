//
//  ColorExtension.swift
//  HealthRecords
//
//  Created by kys-20 on 2018/4/10.
//  Copyright © 2018年 kys-20. All rights reserved.
//

import Foundation
import UIKit
// MARK: - UIColor拓展
extension UIColor
{
    
    /// 根据颜色生成图片
    ///
    /// - Parameters:
    ///   - color: 要生成的颜色
    ///   - size: 要生成的尺寸
    /// - Returns: 返回图片（离屏渲染）
    public class func createImage(color: UIColor, size: CGSize) -> UIImage? {
//        大小
        var rect = CGRect(origin: CGPoint.zero, size: size)
//        颜色
        let co = color
        UIGraphicsBeginImageContext(size)
        defer {
            UIGraphicsEndImageContext()
        }
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(co.cgColor)
        context?.fill(rect)
//        生成图片
        let image = UIGraphicsGetImageFromCurrentImageContext()
        return image
    }
    
}



