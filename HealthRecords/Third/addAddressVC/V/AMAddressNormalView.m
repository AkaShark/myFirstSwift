//
//  AMAddressNormalView.m
//  AMProject
//
//  Created by kys-6 on 2018/4/16.
//  Copyright © 2018年 zuxiuhao. All rights reserved.
//

#import "AMAddressNormalView.h"
#import "UILabel+Adaptive.h"
#import "MOFSPickerManager.h"

@implementation AMAddressNormalView

- (instancetype)initWithFrame:(CGRect)frame andTitle:(NSString *)title andDetail:(NSString *)detail{
    if(self = [super initWithFrame:frame]){
        self.layer.borderWidth = 1;
        self.layer.borderColor = [standardGray CGColor];
        [self createWithTitle:title andDetail:detail];
    }
    return self;
}
- (void)createWithTitle:(NSString *)title andDetail:(NSString *)detail{
    UILabel *titleLabel = [[UILabel alloc]init];
    CGSize titleLabelSize = [titleLabel szieAdaptiveWithText:title andTextFont:[UIFont systemFontOfSize:14] andTextMaxSzie:CGSizeMake(ScreenWidth*400/1242, 0) andHangHeight:0];

    titleLabel.frame = CGRectMake(ScreenWidth*31/1242, self.frame.size.height*57/157, titleLabelSize.width, titleLabelSize.height);
    [self addSubview:titleLabel];
    if (![title isEqualToString:@"标签:"]) {
        self.textField = [[UITextField alloc]initWithFrame:CGRectMake(titleLabel.viewX+titleLabel.viewW, titleLabel.viewY, self.frame.size.width-(titleLabel.viewX+titleLabel.viewW), titleLabel.viewH)];
        [self.textField setFont:[UIFont systemFontOfSize:14]];
        self.textField.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
        self.textField.text = detail;
        [self addSubview:self.textField];

        if([title isEqualToString:@"所在地区:"]){
            self.userInteractionEnabled = YES;
            UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(event:)];
            [self addGestureRecognizer:tapGesture];
            [tapGesture setNumberOfTapsRequired:1];
            
            self.textField.userInteractionEnabled = NO;
        }
    }else{
        
    }
    
}
- (void)event:(UITapGestureRecognizer *)gesture{
    [[MOFSPickerManager shareManger] showMOFSAddressPickerWithDefaultAddress:@"北京市-北京市-东城区" title:@"选择地址" cancelTitle:@"取消" commitTitle:@"确定" commitBlock:^(NSString *address, NSString *zipcode) {
        [self.textField setText:address];
    } cancelBlock:^{
    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.textField resignFirstResponder];
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    self.textField = textField;
    return YES;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
