//
//  UILabel+Adaptive.h
//  CamelliaApp
//
//  Created by kys-6 on 2017/10/4.
//  Copyright © 2017年 kys-20. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Adaptive)
/**
 *  自适应宽高同时调整行距
 *
 *  @param text label.text
 *  @param font label.font
 *  @param size label的最大尺寸
 *
 *  @return 自适应后的到的size
 */
- (CGSize )szieAdaptiveWithText:(NSString *)text andTextFont:(UIFont *)font andTextMaxSzie:(CGSize )size andHangHeight:(CGFloat )height;
@end

