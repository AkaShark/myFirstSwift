//
//  QXPullRefreshLoadingBoll.m
//  Loading_demo
//
//  Created by 张昭 on 22/02/2018.
//  Copyright © 2018 heyfox. All rights reserved.
//

#import "QXPullRefreshLoadingBoll.h"
#import "UIView+Extension.h"
#import "UIColor+QXAppend.h"

#define kTagOffset 10000
#define kBaseSteps 6

@interface QXPullRefreshLoadingBoll ()

@property (nonatomic, assign) CGFloat offsetY;

@end

@implementation QXPullRefreshLoadingBoll

-(instancetype)init{
    if (self = [super init]) {
//        self.backgroundColor = [UIColor colorWithHexString:@"cfcfcf"];
        self.backgroundColor = [UIColor colorWithRed:38/255.0 green:212/255.0 blue: 136/255.0 alpha:1];
        self.layer.cornerRadius = kMinHeight / 2;
        self.enableProgress = true;
        _offsetY = (kMaxHeight - kMinHeight) * 0.4;
    }
    return self;
}

- (void)setProgress:(float)progress {
    _progress = progress;
    
    if (progress < 0) {
        progress = 0;
    } else if (progress > 0.9){
        progress = 0.9;
    }
    if (!self.enableProgress) {
        return;
    }
    _progress = progress;
    
    int step = floor(progress / 0.09 );
    [self refreshFrameLoading:step];
}

-(void)setVerticalOffset:(float)verticalOffset{
    _verticalOffset = verticalOffset;
}

- (void)refreshFrameLoading:(NSInteger)step {
    if (step == 0) {
        self.size = CGSizeMake(kMinHeight, 0);
        return;
    }
    if (step > 0 && step <= 5) {
        float height = (kMaxHeight - kMinHeight ) / 4 * (step - 1) + kMinHeight;
        self.size = CGSizeMake(kMinHeight, height);
        self.y = self.verticalOffset;
    }else if (5 < step && step < 10){
        float  height = kMaxHeight - (step - 5) * (kMaxHeight - kMinHeight ) / 4;
        self.size = CGSizeMake(kMinHeight, height);
        self.y = self.verticalOffset + (step - 5) * (kMaxHeight - kMinHeight) / 4;
    } else if (step == 10) {
        self.y = self.verticalOffset + (kMaxHeight - kMinHeight);
        self.size = CGSizeMake(kMinHeight, kMinHeight);
    } else {
        self.size = CGSizeMake(kMinHeight, kMinHeight);
        if (!self.isDown) {
            self.y = self.y - self.offsetY / kBaseSteps;
            if (self.y < self.verticalOffset + (kMaxHeight - kMinHeight) - self.offsetY) {
                self.y = self.verticalOffset + (kMaxHeight - kMinHeight) - self.offsetY;
                self.isDown = true;
            } else {
                self.isDown = false;
            }
        } else {
            self.y = self.y + self.offsetY / kBaseSteps;
            if (self.y > self.verticalOffset + (kMaxHeight - kMinHeight)) {
                self.y = self.verticalOffset + (kMaxHeight - kMinHeight);
                self.isDown = false;
            } else {
                self.isDown = true;
            }
        }
        if (self.needStop) {
            if (self.tag == kTagOffset && self.y == self.verticalOffset + (kMaxHeight - kMinHeight)) {
                if (self.beginFinishLoading) {
                    self.beginFinishLoading();
                }
                self.needStop = false;
            }
        }
    }
}

- (void)refreshFrameStopLoading:(NSInteger)step {
    
    if (step < kBaseSteps) {
        
        self.y = self.y + self.offsetY / kBaseSteps;
        if (self.y > (kMaxHeight - kMinHeight) + self.verticalOffset) {
            self.y = (kMaxHeight - kMinHeight) + self.verticalOffset;
        }
    }
    else if (step <= kBaseSteps + 5) {
        float height = (kMaxHeight - kMinHeight) * 0.2 * (step - 5 > 5 ? 5 : step - 5) + kMinHeight;
        self.size = CGSizeMake(kMinHeight, height);
        if (step < kBaseSteps + 4) {
            self.y = self.y - (kMaxHeight - kMinHeight) * 0.2;
        } else {
            if (self.y - (kMaxHeight - kMinHeight) * 0.2 <= self.verticalOffset) {
                self.y = self.verticalOffset;
            } else {
                self.y = self.y - (kMaxHeight - kMinHeight) * 0.2;
            }
        }
    } else if (step == kBaseSteps + 6) {
        float height = kMaxHeight - (kMaxHeight - kMinHeight ) / 5;
        self.size = CGSizeMake(kMinHeight, height);
    } else if (step == kBaseSteps + 7) {
        float height = kMaxHeight * 0.5;
        self.size = CGSizeMake(kMinHeight, height);
    } else if (step == kBaseSteps + 8) {
        self.size = CGSizeMake(kMinHeight, kMinHeight);
    } else if (step < kBaseSteps + 16) {
        self.alpha = 1 - (step - (kBaseSteps + 8)) * 0.143;
    }
    
    if (self.tag == kTagOffset && step > kBaseSteps + 4) {
        if (self.beginShowMessage) {
            self.beginShowMessage(step - (kBaseSteps + 4));
        }
    }
}

@end
