//
//  GTagFlowView.h
//  GBigbang
//
//  Created by GIKI on 2017/10/13.
//  Copyright © 2017年 GIKI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GTagFlowItem.h"

typedef void(^GTagFlowViewHeightChanged) (CGFloat original,CGFloat newHeight);
typedef void(^GTagFlowViewSelectedChanged) (BOOL hasSelected);


@protocol backTheSelectedTextArray <NSObject>

-(void)backTheSelectedTextArray: (NSMutableArray *)array;

@end



/**
 盛放collectionView的view
 */
@interface GTagFlowView : UIView

/**
 返回选择文字的代理方法
 */
@property (weak,nonatomic) id<backTheSelectedTextArray> backTheSelectedArray;
/**
 选择的文字的数组
 */
@property (nonatomic,strong) NSMutableArray *selectArray;

@property (nonatomic, strong) UICollectionView * collectionView;
/// 标签行间距 Default:10.f
@property (nonatomic, assign) CGFloat lineSpacing;

/// 标签间距 Default:4.f
@property (nonatomic, assign) CGFloat interitemSpacing;

/// collectionView EdgeInsets
@property (nonatomic, assign) UIEdgeInsets edgeInsets;

/// 是否支持滑动选择 Default:YES
@property (nonatomic, assign) BOOL  supportSlideSelection;

/// 分词数组
@property (nonatomic, strong ) NSArray<GTagFlowItem*> * flowDatas;

/// collectionView 高度改变回调
@property (nonatomic, copy  ) GTagFlowViewHeightChanged  heightChangedBlock;

/// 是否有选中词状态改变回调
@property (nonatomic, copy  ) GTagFlowViewSelectedChanged  selectedChangedBlock;

- (void)reloadDatas;

/**
 配置使用左边对齐的流水布局
 @brief:GTagCollectionView
 */
- (void)configTagCollectionViewLayout;

/**
 使用自定义流水布局

 @param customLayout 传入自定义布局
 */
- (void)configCustomLayout:(__kindof UICollectionViewLayout*)customLayout;

/**
 获取选择词/数组

 @param addingOrder 是否按照选择词顺序生成新词
 @return 新字符串
 */
- (NSString*)getNewTextOrderByAdding:(BOOL)addingOrder;
- (NSArray *)filterAllSelectTitlesOrderByAdding:(BOOL)addingOrder;

/// 按照原有排序生成新字符串
- (NSString*)getNewTextstring;
- (NSArray *)filterAllSelectTitles;
- (NSArray *)filterNoSelectTitles;

@end
