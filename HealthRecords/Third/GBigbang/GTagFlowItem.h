//
//  GTagFlowItem.h
//  GBigbang
//
//  Created by GIKI on 2017/10/13.
//  Copyright © 2017年 GIKI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GBigbangBox.h"

/**
 item设置
 */
@interface GTagFlowAppearance : NSObject
@property (nonatomic, strong) UIColor * textColor;
@property (nonatomic, strong) UIColor * backgroundColor;
@property (nonatomic, strong) UIColor * selectBackgroundColor;
@property (nonatomic, strong) UIColor * selectTextColor;

@property (nonatomic, assign) CGFloat  borderWidth;
@property (nonatomic, strong) UIColor * borderColor;
@property (nonatomic, strong) UIColor * selectBorderColor;

@property (nonatomic, strong) UIFont * textFont;
@property (nonatomic, assign) CGFloat  cornerRadius;

@property (nonatomic, assign) CGFloat itemHeight;

@end

@interface GTagFlowItem : NSObject

@property (nonatomic, strong) NSString * text;

@property (nonatomic, assign) CGSize  itemSize;

@property (nonatomic, strong) GTagFlowAppearance * appearance;

@property (nonatomic, assign) BOOL  isSelected;

/**
 init Method

 @param text <#text description#>
 @return <#return value description#>
 */
+ (instancetype)tagFlowItemWithText:(NSString*)text;
+ (instancetype)tagFlowItemWithText:(NSString*)text withAppearance:(GTagFlowAppearance*)appearance;

/**
 factory Method

 @param items <#items description#>
 @param appearance <#appearance description#>
 @return <#return value description#>
 */
+ (NSArray<GTagFlowItem*>*)factoryFolwLayoutWithItems:(NSArray<GBigbangItem*>*)items withAppearance:(GTagFlowAppearance*)appearance;

@end
