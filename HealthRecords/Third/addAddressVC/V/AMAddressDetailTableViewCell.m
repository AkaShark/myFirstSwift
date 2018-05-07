//
//  AMAddressTableViewCell.m
//  AMProject
//
//  Created by kys-6 on 2018/4/16.
//  Copyright © 2018年 zuxiuhao. All rights reserved.
//

#import "AMAddressDetailTableViewCell.h"
#import "AMAddressNormalView.h"
#import "AMAddressLabelBtn.h"
#import "AMDataModel.h"
#import "LJContactManager.h"
#import <BmobSDK/Bmob.h>
@implementation AMAddressDetailTableViewCell{
    NSDictionary *controlDic;
}
+ (instancetype)cellWithTableView:(UITableView *)tableView andData:(NSDictionary *)dic{
    static NSString *id=@"cell2";
    AMAddressDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:id];
    if (cell==nil)
    {
        cell=[[AMAddressDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:id];
        [cell createUIWith:dic];
    }
    return cell;
}
- (void)createUIWith:(NSDictionary *)dataDic{
    
    
    AMAddressNormalView *consigneeView = [[AMAddressNormalView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth*977/1242, ScreenHeight*157/2208) andTitle:@"家属姓名:"andDetail:[dataDic objectForKey:@"name"]];
    
    [self.contentView addSubview:consigneeView];
    
    AMAddressNormalView *telView = [[AMAddressNormalView alloc]initWithFrame:CGRectMake(0, consigneeView.viewH, consigneeView.viewW, ScreenHeight*157/2208) andTitle:@"家属电话:"andDetail:[dataDic objectForKey:@"phone"]];
    [self.contentView addSubview:telView];
    
    UIButton *connectManBtn = [[UIButton alloc]initWithFrame:CGRectMake(consigneeView.viewW, 0, ScreenWidth*264/1242, consigneeView.viewH*2)];
    [connectManBtn setBackgroundImage:[UIImage imageNamed:@"connectManBtn"] forState:UIControlStateNormal];
    [connectManBtn addTarget:self action:@selector(getAddressBook) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:connectManBtn];
    
    AMAddressNormalView *locationView = [[AMAddressNormalView alloc]initWithFrame:CGRectMake(0, telView.viewY+telView.viewH, ScreenWidth, ScreenHeight*157/2208) andTitle:@"家属关系:"andDetail:[dataDic objectForKey:@"location"]];
    [self.contentView addSubview:locationView];
    
    AMAddressNormalView *sex = [[AMAddressNormalView alloc] initWithFrame:CGRectMake(0, locationView.viewY+locationView.viewH, ScreenWidth, ScreenHeight*157/2208) andTitle:@"家属性别:" andDetail:[dataDic objectForKey:@"sex"]];
    [self.contentView addSubview:sex];
    
    AMAddressNormalView* age = [[AMAddressNormalView alloc] initWithFrame:CGRectMake(0, sex.viewY+sex.viewH, ScreenWidth, ScreenHeight*157/2208) andTitle:@"家属年龄:" andDetail:[dataDic objectForKey:@"age"]];
        [self.contentView addSubview:age];
    
    
    AMAddressNormalView* height = [[AMAddressNormalView alloc] initWithFrame:CGRectMake(0, age.viewY+age.viewH, ScreenWidth, ScreenHeight*157/2208) andTitle:@"家属身高:" andDetail:[dataDic objectForKey:@"height"]];
        [self.contentView addSubview:height];
    
    AMAddressNormalView* weight = [[AMAddressNormalView alloc] initWithFrame:CGRectMake(0, height.viewY+height.viewH, ScreenWidth, ScreenHeight*157/2208) andTitle:@"家属体重:" andDetail:[dataDic objectForKey:@"weight"]];
    
        [self.contentView addSubview:weight];
    
        controlDic = @{@"name":consigneeView,@"phone":telView,@"relationship":locationView,@"sex":sex,@"age":age,@"height":height,@"weight":weight};
    
}


-(void)upLoadData{
    NSMutableArray *dataArray = [NSMutableArray new];
    NSString *username = [NSString new];
    NSArray *array = @[@"name",@"phone",@"relationship"];
    NSMutableDictionary *dic1 = [[NSMutableDictionary alloc]init];
    BOOL test = 1;
    for(NSString *string in array)
    {
        AMAddressNormalView *view = [controlDic objectForKey:string];
        NSString *testString = view.textField.text;
        [dataArray addObject:testString];
    }
//    上传家属信息
    BmobUser *bUser = [BmobUser currentUser];
    if (bUser) {
        username = bUser.username;
        BmobObject *homeGroup = [BmobObject objectWithClassName:@"homeGroup"];
        [homeGroup setObject:username forKey:@"userPhone"];
        [homeGroup setObject:dataArray[2] forKey:@"relation"];
        [homeGroup setObject:dataArray[0] forKey:@"patientName"];
        //[homeGroup setObject:dataArray[0] forKey:@"patlentName"]; 电话字段不传了.
        [homeGroup saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
            if (isSuccessful)
            {
                [self.delegate upLoadTheFamilyOk];
                NSLog(@"上传家属信息ok");
            }
            else
            {
                NSLog(@"上传家属信息失败");
            }
        }];
        
    }else{
        //对象为空时，可打开用户注册界面
    }
    
    if (test) {
        if ([[self viewController].title isEqualToString:@"编辑收货人"]) {
            [AMDataModel replaceDicToPlist:_count andData:dic1];
        }else{
            [AMDataModel setDicToPlist:dic1];
        }
    }
    
}


- (void)getAddressBook{
    [[LJContactManager sharedInstance]selectContactAtController:[self viewController] complection:^(NSString *name, NSString *phone) {
        NSLog(@"%@%@",name,phone);
        
        AMAddressNormalView *view = [controlDic objectForKey:@"name"];
        [view.textField setText:name];
        
        AMAddressNormalView *view1 = [controlDic objectForKey:@"phone"];
        NSString *stringWithoutQuotation = [phone
                                            stringByReplacingOccurrencesOfString:@"-" withString:@""];
        [view1.textField setText:[stringWithoutQuotation stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"]];
    }];
    
}
//- (void)buttonsClick:(UIButton *)sender{
//    for (int i = 0; i<3; i++) {
//        if (sender.tag == 100+i) {
//            sender.selected = YES;
//            sender.layer.borderColor = [standardRed CGColor];
//            [sender setTitleColor:standardRed forState:UIControlStateNormal];
//            continue;
//        }
//         AMAddressNormalView *view = [controlDic objectForKey:@"tag"];
//        AMAddressLabelBtn *but = (AMAddressLabelBtn*)[view viewWithTag:100+i];
//        but.selected = NO;
//        [but setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
//        but.layer.borderColor = [standardGray CGColor];
//    }
//}
- (UIViewController *)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

