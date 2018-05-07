//
//  UIColor+QXAppend.h
//  Loopsone
//
//  Created by UI on 16/12/8.
//  Copyright © 2016年 Kingsingmobi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (QXAppend)

/**
 *  十六进制字符串生成color
 *
 *  @param hexString 十六进制颜色
 *
 *  @return color
 */
+ (UIColor *)colorWithHexString:(NSString *)hexString;
/**
 *  十六进制字符串生成有透明度的color
 *
 *  @param hexString 十六进制颜色
 *  @param alpha     透明度0-1
 *
 *  @return 有透明度的color
 */
+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;

+ (UIColor *)colorWithHex444444;
+ (UIColor *)colorWithHex999999;
+ (UIColor *)colorWithHexf3f3f3;
+ (UIColor *)colorWithGreenColor;
+ (UIColor *)colorWithHex666666;
+ (UIColor *)colorWithHexdcdfe0;
+ (UIColor *)colorWithHexe0e0e0;
+ (UIColor *)colorWithHexcccccc;
+ (UIColor *)colorWithHex111111;

-(int32_t)ARGBHex;
+ (UIColor *)randomColor;

@end
