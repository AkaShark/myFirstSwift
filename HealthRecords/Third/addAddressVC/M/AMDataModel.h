//
//  AMDataModel.h
//  AMProject
//
//  Created by kys-6 on 2018/4/17.
//  Copyright © 2018年 zuxiuhao. All rights reserved.
//

#import <Foundation/Foundation.h>
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height
#define ScreenWidth [[UIScreen mainScreen] bounds].size.width
#define viewX frame.origin.x
#define viewY frame.origin.y
#define viewW frame.size.width
#define viewH frame.size.height

#pragma mark - 颜色
//标准红
#define standardRed [UIColor colorWithRed:235/255.0 green:22/255.0 blue:37/255.0 alpha:1]
//标准暗
#define standardGray [UIColor colorWithRed:236/255.0 green:239/255.0 blue:243/255.0 alpha:1]
//标准字体颜色
#define standardTextColor [UIColor colorWithRed:66/255.0 green:66/255.0 blue:66/255.0 alpha:1]
@interface AMDataModel : NSObject
/**
 *@brief 遍历数据量
 */
+ (NSUInteger)dataCount;
/**
 *@brief 返回对应列数据
 *@param count 数据位置
 */
+ (NSDictionary *)reloadTheDetail:(NSInteger)count;
+ (void)createEditableCopyOfPlistIfNeeded;
+ (void)setDicToPlist:(NSDictionary *)dic;
+ (void)deleteDicToPlist:(NSInteger)count;
+ (void)replaceDicToPlist:(NSInteger)count andData:(NSDictionary *)dic;
@end
