//
//  QXPullRefreshLoadingView.m
//  Loading_demo
//
//  Created by 张昭 on 22/02/2018.
//  Copyright © 2018 heyfox. All rights reserved.
//

#import "QXPullRefreshLoadingView.h"
#import "UIView+Extension.h"
#import "QXPullRefreshLoadingBoll.h"
#import "QXGradientLabel.h"

#define kTagOffset 10000

/**
 出现动画顺序问题 已经解决 查看添加和移除Lable位置
 */
@interface QXPullRefreshLoadingView ()

@property (nonatomic, strong) NSTimer *loadingTimer;
@property (nonatomic, assign) NSInteger steps;
@property (nonatomic, assign) bool beginStopLoading;


@end

@implementation QXPullRefreshLoadingView

- (void)dealloc {
    NSLog(@"------QXPullRefreshLoadingView-----");
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    if (!newSuperview) {
        self.didFinishAnimationBlock = nil;
    }
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

-(void)setupViews{
    for (int i = 0; i < 4; i ++ ) {
        QXPullRefreshLoadingBoll* boll = [[QXPullRefreshLoadingBoll alloc] init];
        boll.tag = i + kTagOffset;
        boll.x = ([UIScreen mainScreen].bounds.size.width - 4 * kMinHeight - 3 * kSpace) / 2 + i * (kSpace + kMinHeight);
        [self addSubview:boll];
    }
    CGSize size = MULTILINE_NEW_TEXTSIZE(@"刷新成功", [UIFont systemFontOfSize:13], CGSizeMake(1000, 40));
    self.gradientLabel = [[QXGradientLabel alloc] initWithFrame:CGRectMake(0, 0, size.width, kMaxHeight)];
    self.gradientLabel.text = @"刷新成功";
//    self.gradientLabel.hidden = YES;
    self.gradientLabel.font = [UIFont systemFontOfSize:13];
    [self.gradientLabel sizeToFit];
    self.gradientLabel.center = CGPointMake([UIScreen mainScreen].bounds.size.width * 0.5, kMinHeight * 0.5);
    self.gradientLabel.progress = 0;
   
}

- (void)setPullingPercent:(float)pullingPercent {
    _pullingPercent = pullingPercent;
    for (int i = 0; i < 4; i ++) {
        QXPullRefreshLoadingBoll* boll = [self viewWithTag:i + kTagOffset];
        boll.enableProgress = true;
        if (pullingPercent < 0.5) {
            boll.progress = 0;
            return;
        }
        if (pullingPercent > 1) {
            pullingPercent = 1;
        }
        boll.progress = (pullingPercent - 0.5) / 0.5 * 0.7 - i * 0.2;
    }
}

-(void)setVerticalOffset:(float)verticalOffset{
    _verticalOffset = verticalOffset;
    for (int i = 0; i < 4; i ++) {
        QXPullRefreshLoadingBoll* boll = [self viewWithTag:i + kTagOffset];
        boll.verticalOffset = verticalOffset;
    }
    self.gradientLabel.y = verticalOffset;
}

#pragma mark 加载动画
-(NSTimer*)loadingTimer{
    if (!_loadingTimer ) {
        _loadingTimer = [NSTimer scheduledTimerWithTimeInterval:kBaseDuratrion target:self selector:@selector(doLoadingAnimation) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_loadingTimer forMode:NSRunLoopCommonModes];
    }
    return _loadingTimer;
}

-(void)startProgressAnimation {
    if (self.loadingTimer) {
        [self.loadingTimer invalidate];
        self.loadingTimer = nil;
        self.steps = 0;
    }
    [self.loadingTimer fire];
}

-(void)stopProgressAnimation{
    QXPullRefreshLoadingBoll *boll = [self viewWithTag: kTagOffset];
    boll.needStop = true;
    __weak typeof(self) weakSelf = self;
    boll.beginFinishLoading = ^{
        if (weakSelf.loadingTimer) {
            [weakSelf.loadingTimer invalidate];
            weakSelf.loadingTimer = nil;
            weakSelf.steps = 0;
        }
        //        NSLog(@"timer重置-->开始执行结束动画");
        weakSelf.beginStopLoading = true;
        [weakSelf startProgressAnimation];
    };
    boll.beginShowMessage = ^(NSInteger step) {
        //        NSLog(@"文字登场---%ld", step);
         [self addSubview:self.gradientLabel];
        weakSelf.gradientLabel.progress = step * 0.075 > 1.0 ? 1.0 : step * 0.075;
        [weakSelf.gradientLabel setNeedsDisplay];
        if (step == 26) {
            weakSelf.gradientLabel.progress = 0;
            weakSelf.beginStopLoading = nil;
            if (weakSelf.loadingTimer) {
                [weakSelf.loadingTimer invalidate];
                weakSelf.loadingTimer = nil;
                weakSelf.steps = 0;
                NSLog(@"刷新成功");
            }
            for (int i = 0; i < 4; i ++) {
                QXPullRefreshLoadingBoll *boll = [weakSelf viewWithTag:i + kTagOffset];
                boll.enableProgress = true;
                boll.progress = 0.0;
                boll.alpha = 1;
                boll.isDown = false;
            }
            if (weakSelf.didFinishAnimationBlock) {
                weakSelf.didFinishAnimationBlock();
                weakSelf.didFinishAnimationBlock = nil;
                [self.gradientLabel removeFromSuperview];
            }
        }
    };
    
}

- (void)doLoadingAnimation {
    self.steps += 1;
    //    NSLog(@"%ld", self.steps);
    
    for (int i = 0; i < 4; i ++) {
        QXPullRefreshLoadingBoll* boll = [self viewWithTag:i + kTagOffset];
        boll.enableProgress = false;
        
        if (!self.beginStopLoading) {
            int step = floor(boll.progress / 0.09 );
            boll.progress += 0.1;
            [boll refreshFrameLoading:step];
        } else {
            if (self.steps == 1) {
                boll.progress = (3 - i) * 0.2;
            }
            int step = floor(boll.progress * 10);
            boll.progress += 0.1;
            [boll refreshFrameStopLoading:step];
        }
    }
    
}

- (void)beginLoading {
    for (int i = 0; i < 4; i ++) {
        QXPullRefreshLoadingBoll* boll = [self viewWithTag:i + kTagOffset];
        if (i == 0) {
            boll.progress = 0.7;
        } else if (i == 1) {
            boll.progress = 0.5;
        } else if (i == 2) {
            boll.progress = 0.3;
        } else {
            boll.progress = 0.1;
        }
    }
    [self startProgressAnimation];
}

- (void)endLoading {
    [self stopProgressAnimation];
}

- (void)setIsFail:(BOOL)isFail {
    
    _isFail = isFail;
    if (isFail) {
        self.gradientLabel.text = @"刷新失败";
    } else {
       
//        self.gradientLabel.hidden = false;
        self.gradientLabel.text = @"刷新成功";  
    }
}

@end
