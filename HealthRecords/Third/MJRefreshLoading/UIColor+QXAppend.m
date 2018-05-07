//
//  UIColor+QXAppend.m
//  Loopsone
//
//  Created by UI on 16/12/8.
//  Copyright © 2016年 Kingsingmobi. All rights reserved.
//

#import "UIColor+QXAppend.h"

@implementation UIColor (QXAppend)
/// 十六进制转换 + 不透明
+ (UIColor *)colorWithHexString:(NSString *)hexString
{
    return [self colorWithHexString:hexString alpha:1.0f];
}

/// 十六进制转换 + 透明度
+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha
{
    unsigned int red, green, blue;
    
    NSInteger startIndex = 0;
    
    
    if (hexString.length == 7 && [hexString hasPrefix:@"#"]) {
        startIndex = 1;
    }else if (hexString.length == 8 && ([hexString hasPrefix:@"0x"]|| [hexString hasPrefix:@"0X"])){
    
        startIndex = 2;
    }else if (hexString.length == 6){
    
        startIndex = 0;
    }
    
    NSRange range;
    range.length =2;
    range.location = startIndex;
    [[NSScanner scannerWithString:[hexString substringWithRange:range]]scanHexInt:&red];
    range.location = startIndex + 2;
    [[NSScanner scannerWithString:[hexString substringWithRange:range]]scanHexInt:&green];
    range.location = startIndex + 4;
    [[NSScanner scannerWithString:[hexString substringWithRange:range]]scanHexInt:&blue];
    
    return [UIColor colorWithRed:(float)(red/255.0f)green:(float)(green/255.0f)blue:(float)(blue/255.0f)alpha:alpha];
}

+ (UIColor *)colorWithHex444444
{
    return [UIColor colorWithHexString:@"#444444"];
}

+ (UIColor *)colorWithHex666666
{
    return [UIColor colorWithHexString:@"#666666"];
}

+ (UIColor *)colorWithHex999999
{
    return [UIColor colorWithHexString:@"#999999"];
}

+ (UIColor *)colorWithGreenColor
{
    return [UIColor colorWithHexString:@"#56c66b"];
}

+ (UIColor *)colorWithHexf3f3f3
{
    return [UIColor colorWithHexString:@"#f3f3f3"];
}

+ (UIColor *)colorWithHexdcdfe0
{
    return [UIColor colorWithHexString:@"dcdfe0"];
}

+ (UIColor *)colorWithHexe0e0e0
{
    return [UIColor colorWithHexString:@"#e0e0e0"];
}

+ (UIColor *)colorWithHexcccccc
{
    return [UIColor colorWithHexString:@"#cccccc"];
}

+ (UIColor *)colorWithHex111111
{
    return [UIColor colorWithHexString:@"#111111"];
}

-(int32_t)ARGBHex{
    
    CGFloat red, green,blue,alpha;
    [self getRed:&red green:&green blue:&blue alpha:&alpha];
    

    
    int32_t ARGB = ((int)alpha << 2^24 )+ ((int)red<< 2^16 ) + ((int)green <<2^8) + (int)blue;
    
    NSLog(@"ARGB = %x",ARGB);
    
    return 0xffffffff;
    return ARGB;
}

+ (UIColor *)randomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  // 0.5 to 1.0,away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //0.5 to 1.0,away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

@end
