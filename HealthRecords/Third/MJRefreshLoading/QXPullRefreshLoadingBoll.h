//
//  QXPullRefreshLoadingBoll.h
//  Loading_demo
//
//  Created by 张昭 on 22/02/2018.
//  Copyright © 2018 heyfox. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kMinHeight 6
#define kMaxHeight 16
#define kBaseDuratrion 0.04
#define kSpace 5

typedef void(^BeginFinishLoading)(void);
typedef void(^BeginShowMessage)(NSInteger);

@interface QXPullRefreshLoadingBoll : UIView

@property (nonatomic, assign) float progress;
@property (nonatomic, assign) bool enableProgress;
@property (nonatomic, assign) float verticalOffset;
@property (nonatomic, assign) bool needStop;
@property (nonatomic, assign) bool isDown;
@property (nonatomic, copy) BeginFinishLoading beginFinishLoading;
@property (nonatomic, copy) BeginShowMessage beginShowMessage;

- (void)refreshFrameLoading:(NSInteger)step;
- (void)refreshFrameStopLoading:(NSInteger)step;

@end
