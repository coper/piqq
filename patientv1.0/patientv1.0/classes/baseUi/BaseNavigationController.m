//
//  BaseNavigationController.m
//  patientv1.0
//
//  Created by liyongli on 15-7-1.
//  Copyright (c) 2015年 ask. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //1. 设置NavigationController的背景颜色
    self.view.backgroundColor = [LibFun hexStringToColor:TOP_BGCOLOR];
    //2.取出设置主题的对象
    UINavigationBar *navBar = [UINavigationBar appearance];
    UIBarButtonItem *barItem = [UIBarButtonItem appearance];
    navBar.translucent = NO;
    navBar.barTintColor = [LibFun hexStringToColor:TOP_BGCOLOR];
    
    navBar.tintColor = [UIColor whiteColor];
    [navBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    //2.设置导航栏标题颜色
    [navBar setTitleTextAttributes:@{
                                     NSForegroundColorAttributeName :[LibFun hexStringToColor:@"#ffffff"] ,
                                     NSFontAttributeName : kFont(20)
                                     }];

    //3.设置导航栏按钮文字颜色
    [barItem setTitleTextAttributes:@{
                                      NSForegroundColorAttributeName : [LibFun hexStringToColor:@"#ffffff"],
                                      NSFontAttributeName : kFont(18)
                                      } forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
