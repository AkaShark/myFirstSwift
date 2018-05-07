//
//  UILabel+Adaptive.m
//  CamelliaApp
//
//  Created by kys-6 on 2017/10/4.
//  Copyright © 2017年 kys-20. All rights reserved.
//

#import "UILabel+Adaptive.h"

@implementation UILabel (Adaptive)

- (CGSize )szieAdaptiveWithText:(NSString *)text andTextFont:(UIFont *)font andTextMaxSzie:(CGSize )size andHangHeight:(CGFloat )height{
    
    self.text = text;
    self.font = font;
    
    //可变的属性文本
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc]initWithString:self.text];
    
    //设置段落样式 使用NSMutableParagraphStyle类
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    paragraphStyle.alignment = NSTextAlignmentLeft;//文本对齐方式
    paragraphStyle.maximumLineHeight = 60;  //最大的行高
    if (height == 0) {
        paragraphStyle.lineSpacing = 8;  //行自定义行高度
    }else{
        paragraphStyle.lineSpacing = height;
    }
    
    //  给可变的属性字符串 添加段落格式
    [attributedText addAttribute: NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.text length])];
    
    //将带有段落格式的可变的属性字符串给label.attributedText
    self.attributedText = attributedText;
    
    self.lineBreakMode = NSLineBreakByTruncatingTail;//label的换行模式
    self.numberOfLines = 0;// 设置行数，0表示没有限制
    
    CGSize maxSzie = size;//设置label的最大SIZE
    
    [self sizeToFit];
    CGSize labelSize = [self sizeThatFits:maxSzie];//最终自适应得到的label的尺寸。
    
    
    return labelSize;
}


@end
