//
//  QXRefreshHeader.m
//  MJRefreshLoadingDemo
//
//  Created by 张昭 on 12/03/2018.
//  Copyright © 2018 heyfox. All rights reserved.
//

#import "QXRefreshHeader.h"

@implementation QXRefreshHeader

#pragma mark - 覆盖父类的方法
- (void)prepare
{
    [super prepare];
    self.stateLabel.hidden = true;
    if (!_pullView) {
        QXPullRefreshLoadingView *pullView = [[QXPullRefreshLoadingView alloc] initWithFrame:self.bounds];
        [self addSubview:_pullView = pullView];
    }
    
}

- (void)placeSubviews
{
    [super placeSubviews];
    _pullView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.mj_h);
    _pullView.verticalOffset = self.mj_h * 0.5 - 8;
}

- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];
    if (self.state == MJRefreshStateRefreshing) {
        return;
    }
    _pullView.pullingPercent = pullingPercent;
}

-(void)setState:(MJRefreshState)state{
    MJRefreshCheckState
    
    if (state == MJRefreshStateRefreshing) {
        self.isFail = false;
        [_pullView beginLoading];
    }
}

-(void)endRefreshing{
    _pullView.isFail = self.isFail;
    [_pullView endLoading];
    __weak typeof(self) weakSelf = self;
    _pullView.didFinishAnimationBlock = ^{
        [weakSelf tmpSuperEndRefreshing];
    };
}

-(void)tmpSuperEndRefreshing{
    [super endRefreshing];
}

@end
