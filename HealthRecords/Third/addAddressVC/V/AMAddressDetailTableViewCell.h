//
//  AMAddressTableViewCell.h
//  AMProject
//
//  Created by kys-6 on 2018/4/16.
//  Copyright © 2018年 zuxiuhao. All rights reserved.
//

#import <UIKit/UIKit.h>

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

@protocol upLoadTheFamilyDelegate <NSObject>

-(void)upLoadTheFamilyOk;


@end

@interface AMAddressDetailTableViewCell : UITableViewCell


@property (nonatomic,weak) id <upLoadTheFamilyDelegate> delegate;

@property (nonatomic,assign)NSInteger count;

@property (nonatomic,strong) UIButton *upLoadBtn;
+ (instancetype)cellWithTableView:(UITableView *)tableView andData:(NSDictionary *)dic;
-(void)upLoadData;
@end
