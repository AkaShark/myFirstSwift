//
//  AMAddressTableView.m
//  AMProject
//
//  Created by kys-6 on 2018/4/16.
//  Copyright © 2018年 zuxiuhao. All rights reserved.
//

#import "AMAddressTableView.h"

@implementation AMAddressTableView
{
    NSDictionary *dataDic;
}
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style andData:(NSDictionary *)dic{
    self = [super initWithFrame:frame style:style];
    
    if (self) {
        self.separatorColor = standardGray;
        self.showsVerticalScrollIndicator = YES;
        self.showsHorizontalScrollIndicator = NO;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        self.allowsSelection = NO;
        self.delegate = self;
        self.dataSource = self;
        dataDic = dic;
    }
    
    return self;
    
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScreenHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AMAddressDetailTableViewCell *cell = [AMAddressDetailTableViewCell cellWithTableView:tableView andData:dataDic];
    cell.count = _count;
    self.cell = cell;
//    cell.xlDelegate = self;
//    cell.selectedIndexPath = indexPath;
//    //    [cell.defaultBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
//    //    cell.defaultBtn.tag = indexPath.row;
//    if (0 == indexPath.section) {
//        [cell.defaultBtn setBackgroundImage:[UIImage imageNamed:@"select"] forState:UIControlStateNormal];
//        cell.defaultLabel.text = @"默认地址";
//        _selectedIndexPath = indexPath;
//    }else{
//        [cell.defaultBtn setBackgroundImage:[UIImage imageNamed:@"notSelect"] forState:UIControlStateNormal];
//        cell.defaultLabel.text = @"设为默认";
//    }
    return cell;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
