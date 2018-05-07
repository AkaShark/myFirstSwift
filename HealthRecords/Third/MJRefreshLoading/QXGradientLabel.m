//
//  QXGradientLabel.m
//  Loading_demo
//
//  Created by 张昭 on 24/02/2018.
//  Copyright © 2018 heyfox. All rights reserved.
//

#import "QXGradientLabel.h"

@interface QXGradientLabel ()

@property (nonatomic, strong) CAGradientLayer *gradientLayer;
@property (nonatomic, strong) UIColor *mColor;

@end

@implementation QXGradientLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatGradientLayer];
    }
    return self;
}

- (void)creatGradientLayer {
//    self.mColor = [UIColor colorWithHexString:@"cfcfcf"];
    
    self.mColor = [UIColor colorWithRed:38/255.0 green:212/255.0 blue: 136/255.0 alpha:1];
    self.textColor = self.mColor;
    self.progress = 0;
    self.gradientLayer = [CAGradientLayer layer];
    NSArray *colors = [NSArray arrayWithObjects:
                       (id)[self.mColor CGColor],
                       (id)[self.mColor CGColor],
                       (id)[[UIColor colorWithWhite:0 alpha:0] CGColor],
                       nil];
    [self.gradientLayer setColors:colors];
    [self.gradientLayer setStartPoint:CGPointMake(0.0f, 0.0f)];
    [self.gradientLayer setEndPoint:CGPointMake(1.0f, 1.0f)];
    [self.gradientLayer setFrame:self.bounds];
    [self.layer setMask:self.gradientLayer];
}

- (void)setProgress:(float)progress {
    _progress = progress;
    NSArray *colors = [NSArray arrayWithObjects:
                       (id)[self.mColor CGColor],
                       (id)[self.mColor CGColor],
                       (id)[[UIColor colorWithWhite:0 alpha:progress * 0.75] CGColor],
                       nil];
    [self.gradientLayer setColors:colors];
    [self.gradientLayer setEndPoint:CGPointMake(progress, progress)];
    if (progress >= 1.0) {
        [self.layer setMask:nil];
    } else {
        if (!self.layer.mask) {
            [self.layer setMask:self.gradientLayer];
        }
    }
    [self.gradientLayer setNeedsLayout];
}

- (void)setMessage:(NSString *)message {
    _message = message;
}


@end
