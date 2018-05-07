//
//  UIView+Extension.h
//  MiniK
//
//  Created by 杜奎 on 2017/8/1.
//  Copyright © 2017年 UI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;

@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;
@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;
@property (nonatomic) CGPoint origin;
@property (nonatomic) CGSize  size;

-(UIViewController *)viewcontroller;

- (void)setBackgroundShadow:(UIColor *)shadowColor CGSize:(CGSize)CGSize shadowOpacity:(float)shadowOpacity shadowRadius:(float)shadowRadius;

- (CALayer *)genericShadowLayerWithRadius:(CGFloat)radius;
- (CALayer *)createLayerWithShadowColor:(UIColor *)shadowColor CGSize:(CGSize)shadownSize shadowOpacity:(CGFloat)shadowOpacity shadowRadius:(CGFloat)shadowRadius cornerRadius:(CGFloat)cornerRadius;
- (UIView *)copyToNewView;


@end

@interface UIView (QXAnimation)

-(void)qx_startRotation:(NSTimeInterval)duration clockwise:(BOOL)clockwise;
-(void)qx_stopRotation;

-(void)qx_resetRotation;

@end

