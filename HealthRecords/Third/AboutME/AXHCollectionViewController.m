//
//  AXHCollectionViewController.m
//  AXHProject
//
//  Created by kys-5 on 16/8/31.
//  Copyright © 2016年 kys-5. All rights reserved.
//

#import "AXHCollectionViewController.h"


@interface AXHCollectionViewController ()


@property(nonatomic,strong)UITextView* aboutUsLabel;

@property(nonatomic,strong)UIImageView* imageView;
@end

@implementation AXHCollectionViewController


-(UIImageView*)imageView{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc]initWithFrame:
                      CGRectMake(([UIScreen mainScreen].bounds.size.width-184)/2, 64, 184, 165)];
        
        _imageView.image = [UIImage imageNamed:@"关于我们.jpg"];
        [self.view addSubview:_imageView];
        
    }
    return _imageView;
}


-(UITextView*)aboutUsLabel{
    if (_aboutUsLabel == nil) {
        NSString* string = [NSString stringWithFormat:@"需求命题:基于智能识别的健康档案管理系统\n\n命题企业:浙江正元智慧科技股份有限公司\n\n咨询邮箱:huangpan@360ser.com\n\n河北北方学院-梦之队\n\n刘述豪，朱修昊，范新烨，许晓程，岳天天"];
 
        _aboutUsLabel = [[UITextView alloc]initWithFrame:
                         CGRectMake(20,
                                    _imageView.frame.origin.y+_imageView.frame.size.height+20, self.view.frame.size.width-40, self.view.frame.size.height)];
        _aboutUsLabel.allowsEditingTextAttributes = NO;
        _aboutUsLabel.font = [UIFont systemFontOfSize:24];
        _aboutUsLabel.textColor = [UIColor lightGrayColor];
        _aboutUsLabel.text = string;
        [self.view addSubview:_aboutUsLabel];
        
    }

    return _aboutUsLabel;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"关于我们";
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self imageView];
    [self aboutUsLabel];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
