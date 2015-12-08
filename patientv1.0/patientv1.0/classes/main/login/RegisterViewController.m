//
//  RegisterViewController.m
//  patientv1.0
//
//  Created by liyongli on 15-7-1.
//  Copyright (c) 2015年 ask. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegisterDetailViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //显示右边按钮， 显示左边按钮
    //1. 纯icon
    //[self setLeftNavBtn:@"TXIC" withTarget:@selector(nextStepButtonClicked:)];
    //2. icon + 文字：  < 返回
    [self setLeftNavBtn:nil withTarget:nil];

    //1. 纯icon
    //[self setRightNavBtn:@"tj" title:nil withTarget:@selector(nextStepButtonClicked:)];
    //2. 纯文字，  保存...
    [self setRightNavBtn:nil title:@"保存" withTarget:@selector(nextStepButtonClicked:)];
    @try
    {
//        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"value1", @"key1", @"value2", @"key2", nil];
//        NSArray *cityArray = [NSArray arrayWithArray:dict];
    }
    @catch (NSException *exception)
    {
        NSLogError(@"在这里能捕获到异常，不会使程序崩溃:    %@", exception);
    }
    @finally
    {
        NSLog(@"把程序指引到这里，做出弹窗，方便调试，修改 ");
    }
}


- (void)nextStepButtonClicked:(UIButton *)button
{
    [self pushController:[RegisterDetailViewController class] withInfo:@"完善注册资料"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
