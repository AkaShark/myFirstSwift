//
//  AMNewAddressViewController.m
//  AMProject
//
//  Created by kys-6 on 2018/4/16.
//  Copyright © 2018年 zuxiuhao. All rights reserved.
//

#import "AMNewAddressViewController.h"
#import "AMAddressTableView.h"
#import "AMDataModel.h"

@interface AMNewAddressViewController ()<upLoadTheFamilyDelegate>
@property (nonatomic ,strong)AMAddressTableView *mainTableView;


@end

@implementation AMNewAddressViewController


-(void)viewWillAppear:(BOOL)animated
{
    //创建一个UIButton
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
//    btn.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 10)
    backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 10);
    //设置UIButton的图像
    [backButton setImage:[UIImage imageNamed:@"返回-3"] forState:UIControlStateNormal];
    //给UIButton绑定一个方法，在这个方法中进行popViewControllerAnimated
    [backButton addTarget:self action:@selector(backItemClick) forControlEvents:UIControlEventTouchUpInside];
    //然后通过系统给的自定义BarButtonItem的方法创建BarButtonItem
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    //覆盖返回按键
    self.navigationItem.leftBarButtonItem = backItem;
    
}

-(void)backItemClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationItem.title = @"添加家庭成员";
    
    self.view.backgroundColor = [UIColor whiteColor];
    //导航栏遮挡问题
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.edgesForExtendedLayout =UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
    if ([self.title isEqualToString:@"编辑收货人"]) {
        //右侧按钮
        UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"删除" style:UIBarButtonItemStylePlain target:self action:@selector(deleteData)];
        self.navigationItem.rightBarButtonItem=anotherButton;
    }
    [self creatView];
}
- (void)creatView{
    self.mainTableView = [[AMAddressTableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain andData:_dataDic];
    self.mainTableView.count = _count;
    self.mainTableView.cell.delegate = self;
    self.mainTableView.scrollEnabled = NO;
    [self.view addSubview:self.mainTableView];

    UIButton *saveBtn = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth*249/1242, ScreenHeight*1200/2208, ScreenWidth*746/1242, ScreenHeight*121/2018)];
    [saveBtn setBackgroundImage:[UIImage imageNamed:@"save"] forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(upLoadData) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveBtn];
    
}

/**
 点击保存按钮上传服务器~
 */
- (void)upLoadData{
    [self.mainTableView.cell upLoadData];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)deleteData{
    [AMDataModel deleteDicToPlist:_count];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark =====代理 =====
- (void)upLoadTheFamilyOk
{
//    代理方法没有写
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
