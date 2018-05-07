//
//  UIView+Extension.m
//  MiniK
//
//  Created by 杜奎 on 2017/8/1.
//  Copyright © 2017年 UI. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (CGFloat)right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX
{
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY
{
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)size{
    return self.frame.size;
}

- (void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (UIViewController *)viewcontroller
{
    for (UIView *next = [self superview]; next; next = next.superview)
    {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]])
        {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}


- (void)setBackgroundShadow:(UIColor *)shadowColor CGSize:(CGSize)CGSize shadowOpacity:(float)shadowOpacity shadowRadius:(float)shadowRadius
{
    self.layer.shadowColor = shadowColor.CGColor;
    self.layer.shadowOffset = CGSize;
    self.layer.shadowOpacity = shadowOpacity;
    self.layer.shadowRadius = shadowRadius;
    self.clipsToBounds = NO;
}

//- (CALayer *)genericShadowLayerWithRadius:(CGFloat)radius
//{
//    return  [self createLayerWithShadowColor:[UIColor colorWithHexString:@"#000000"] CGSize:CGSizeMake(0, 2) shadowOpacity:0.26 shadowRadius:2 cornerRadius:radius];
//}

- (CALayer *)createLayerWithShadowColor:(UIColor *)shadowColor CGSize:(CGSize)shadownSize shadowOpacity:(CGFloat)shadowOpacity shadowRadius:(CGFloat)shadowRadius cornerRadius:(CGFloat)cornerRadius
{
    CALayer *subLayer = [CALayer layer];
    subLayer.frame = self.frame;
    subLayer.cornerRadius = cornerRadius;
    subLayer.backgroundColor = [UIColor whiteColor].CGColor;
    subLayer.masksToBounds = NO;
    subLayer.shadowColor = shadowColor.CGColor;
    subLayer.shadowOffset = shadownSize;
    subLayer.shadowOpacity = shadowOpacity;
    subLayer.shadowRadius = shadowRadius;
    return subLayer;
}

- (UIView *)copyToNewView
{
    NSData * tempArchive = [NSKeyedArchiver archivedDataWithRootObject:self];
    return [NSKeyedUnarchiver unarchiveObjectWithData:tempArchive];
}



@end

@implementation UIView (QXAnimation)

-(void)qx_startRotation:(NSTimeInterval)duration clockwise:(BOOL)clockwise{
    
    
    NSString* kAnimationKey = @"kRotation";
    float currentState = 0;
    // Get current state
    
   currentState = [[self.layer.presentationLayer valueForKeyPath:@"transform.rotation.z"] floatValue];
    
    if (![self.layer animationForKey:kAnimationKey]) {
        
        CABasicAnimation *animate =[CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        
        animate.duration = duration;
        animate.repeatCount = CGFLOAT_MAX;
        
        animate.fromValue = @(currentState); //Should the value be nil, will start from 0 a.k.a. "the beginning".
        animate.byValue = clockwise ? @(M_PI * 2.0) : @(-M_PI * 2.0);
        
        [self.layer addAnimation:animate forKey:kAnimationKey];
    
        }
}

-(void)qx_stopRotation{
    
    NSString *kAnimationKey = @"kRotation";
    float currentState;
    
    currentState = [[self.layer.presentationLayer valueForKeyPath:@"transform.rotation.z"] floatValue];

    
    [self.layer removeAnimationForKey:kAnimationKey];

    // Leave self as it was when stopped.
    self.layer.transform = CATransform3DMakeRotation(currentState, 0, 0, 1);
    
    
}

-(void)qx_resetRotation{
    
    self.layer.transform = CATransform3DMakeRotation(0, 0, 0, 1);
}

@end


