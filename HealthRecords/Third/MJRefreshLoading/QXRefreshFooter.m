//
//  QXRefreshFooter.m
//  MiniK
//
//  Created by Mac on 2017/9/5.
//  Copyright © 2017年 UI. All rights reserved.
//

#import "QXRefreshFooter.h"
#import "UIColor+QXAppend.h"
#import "QXPullRefreshLoadingView.h"

@interface QXRefreshFooter ()

@property (nonatomic, strong) UIView *leftLineView;
@property (nonatomic, strong) UIView *rightLineView;

@end

@implementation QXRefreshFooter

-(void)prepare{
    
    [super prepare];
    [self setTitle:@"玩命加载中" forState:MJRefreshStateRefreshing];
    [self setTitle:@"哎呀，被你看光了~" forState:MJRefreshStateNoMoreData];
    self.stateLabel.textColor = [UIColor colorWithHexString:@"#cccccc"];
    self.stateLabel.font = [UIFont systemFontOfSize:14];
    
}

- (void)placeSubviews
{
    [super placeSubviews];
    if (self.state == MJRefreshStateNoMoreData) {
        if (!self.leftLineView.superview) {
            [self addSubview:self.leftLineView];
            self.leftLineView.mj_y = self.mj_h * 0.5 - 0.25;
        }
        if (!self.rightLineView.superview) {
            [self addSubview:self.rightLineView];
            self.rightLineView.mj_y = self.mj_h * 0.5 - 0.25;
        }
        self.rightLineView.hidden = NO;
        self.leftLineView.hidden = NO;
    }else {
        self.leftLineView.hidden = YES;
        self.rightLineView.hidden = YES;
    }
}

- (UIView *)leftLineView
{
    if (!_leftLineView) {
        CGSize titleSize = MULTILINE_NEW_TEXTSIZE(@"哎呀，被你看光了~",[UIFont systemFontOfSize:14], CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX));
        _leftLineView = [[UIView alloc] initWithFrame:CGRectMake(15, 0, ([UIScreen mainScreen].bounds.size.width - titleSize.width) * 0.5 - 15 - 16, 0.5)];
        _leftLineView.backgroundColor = [UIColor colorWithHexe0e0e0];
    }
    return _leftLineView;
}

- (UIView *)rightLineView
{
    if (!_rightLineView) {
        CGSize titleSize = MULTILINE_NEW_TEXTSIZE(@"哎呀，被你看光了~",[UIFont systemFontOfSize:14], CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX));
        _rightLineView = [[UIView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width + titleSize.width) * 0.5 + 16, 0, ([UIScreen mainScreen].bounds.size.width - titleSize.width) * 0.5 - 15 - 16, 0.5)];
        _rightLineView.backgroundColor = [UIColor colorWithHexe0e0e0];
    }
    return _rightLineView;
}

@end


