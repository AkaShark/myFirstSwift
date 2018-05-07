//
//  QXRefreshHeader.h
//  MJRefreshLoadingDemo
//
//  Created by 张昭 on 12/03/2018.
//  Copyright © 2018 heyfox. All rights reserved.
//

#import <MJRefresh/MJRefresh.h>
#import "QXPullRefreshLoadingView.h"

@interface QXRefreshHeader : MJRefreshStateHeader

@property (nonatomic ,weak) QXPullRefreshLoadingView *pullView;
@property (nonatomic, assign) BOOL isFail;

@end
