//
//  QXPullRefreshLoadingView.h
//  MiniK
//
//  Created by Mac on 2018/2/12.
//  Copyright © 2018年 UI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QXGradientLabel.h"
#define MULTILINE_NEW_TEXTSIZE(text, font, maxSize) ({CGSize size = [text \
boundingRectWithSize:maxSize options:(NSStringDrawingUsesLineFragmentOrigin) \
attributes:@{NSFontAttributeName:font} context:nil].size; \
CGSizeMake(ceilf(size.width), ceilf(size.height));})

@interface QXPullRefreshLoadingView : UIView
@property (nonatomic, strong) QXGradientLabel *gradientLabel;
@property (nonatomic, assign) float pullingPercent;
@property (nonatomic, assign) float verticalOffset;
@property (nonatomic, assign) BOOL isFail;
@property (nonatomic, copy) void(^didFinishAnimationBlock)(void);

-(void)beginLoading;

-(void)endLoading;

@end
