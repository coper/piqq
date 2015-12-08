//
//  RegisterDetailViewController.m
//  patientv1.0
//
//  Created by liyongli on 15/7/3.
//  Copyright (c) 2015年 ask. All rights reserved.
//

#import "RegisterDetailViewController.h"

@interface RegisterDetailViewController ()

@end

@implementation RegisterDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //默认的太促
    [self setLeftNavBtn:nil withTarget:nil];
}


//设置导航栏
-(BOOL)isHiddenNavBar
{
    return  NO;
}

- (void)didReceiveMemoryWarning
{
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
