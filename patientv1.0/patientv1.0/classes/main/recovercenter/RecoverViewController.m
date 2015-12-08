//
//  RecoverViewController.m
//  patientv1.0
//
//  Created by liyongli on 15/7/3.
//  Copyright (c) 2015年 ask. All rights reserved.
//

#import "RecoverViewController.h"
#import "CenterViewController.h"

@interface RecoverViewController ()

@end

@implementation RecoverViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //设置左边按钮
    [self setLeftNavBtn:@"TXIC" withTarget:@selector(jumpPersonalCenter:)];
    //设置右边按钮
    [self setRightNavBtn:@"tj" title:nil withTarget:@selector(jumpPersonalCenter:)];
}

- (void)jumpPersonalCenter:(UIButton *)button
{
    NSLog(@"进入个人中心");
    [self pushController:[CenterViewController class] withInfo:nil withTitle:@"个人中心"];
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
