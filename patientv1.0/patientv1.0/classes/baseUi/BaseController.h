//
//  BaseController.h
//  patientv1.0
//
//  Created by liyongli on 15-7-1.
//  Copyright (c) 2015年 ask. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LibFun.h"
#import "DictionaryWithString.h"
//#import "HttpTool.h"

@interface BaseController : UIViewController<UIGestureRecognizerDelegate>

@property (nonatomic,strong) id  userInfo;
@property (nonatomic,strong) id  otherInfo;
@property (nonatomic,assign) int page;

#pragma 弹出窗口的方法
- (BaseController*)pushController:(Class)controller withOnlyInfo:(id)info;
- (BaseController*)pushController:(Class)controller withInfo:(id)info;
- (BaseController*)pushController:(Class)controller withInfo:(id)info withTitle:(NSString*)title;
- (BaseController*)pushController:(Class)controller withInfo:(id)info withTitle:(NSString*)title withOther:(id)other;
- (BaseController*)pushController:(Class)controller withInfo:(id)info withTitle:(NSString*)title withOther:(id)other withModel:(BOOL)isModel;


- (void)popController:(id)controller;
- (BOOL)popController:(NSString*)controller withSel:(SEL)sel withObj:(id)info;

#pragma 添加的方法
//左边按钮
-(void)setLeftNavBtn:(NSString *)iconName withTarget:(SEL)sel;
//右边按钮
-(void)setRightNavBtn:(NSString *)iconName title:(NSString *)titleStr withTarget:(SEL)sel;
//显示隐藏最上面的导航栏
-(BOOL)isHiddenNavBar;

//转换颜色值
-(UIColor *)hexStringToColor: (NSString *) stringToConvert;

@end
