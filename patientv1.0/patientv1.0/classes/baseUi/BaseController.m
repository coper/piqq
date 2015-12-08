//
//  BaseController.m
//  patientv1.0
//
//  Created by liyongli on 15-7-1.
//  Copyright (c) 2015年 ask. All rights reserved.
//

#import "BaseController.h"

@interface BaseController ()


@end

@implementation BaseController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0.941 alpha:1.000];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
    
    //设置左边按钮，默认是显示 返回
    [self setLeftNavBtn:nil withTarget:nil];
}


#pragma mark - Methods
- (BaseController*)pushController:(Class)controller withInfo:(id)info
{
    return [self pushController:controller withInfo:info withTitle:nil withOther:nil];
}
- (BaseController*)pushController:(Class)controller withInfo:(id)info withTitle:(NSString*)title
{
    return [self pushController:controller withInfo:info withTitle:title withOther:nil];
}
- (BaseController*)pushController:(Class)controller withInfo:(id)info withTitle:(NSString*)title withOther:(id)other
{
    return [self pushController:controller withInfo:info withTitle:title withOther:other withModel:NO];
}
/**
 *	自动配置次级controller头部并跳转
 *  次级controller为base的基类的时候，参数生效，否则无效
 *
 *	@param	controller	次级controller
 *	@param	info	主参数
 *	@param	title	次级顶部title（次级设置优先）
 *	@param	other	附加参数
 *
 *	@return	次级controller实体
 */
- (BaseController*)pushController:(Class)controller withInfo:(id)info withTitle:(NSString*)title withOther:(id)other withModel:(BOOL)isModel
{
    NSLog(@"\n===============================================\nUserInfo:%@\n===============================================\notherInfo %@\n===============================================\ncontroller:%@\n===============================================\ntitle:%@\n===============================================\n",info, other, controller, title);
    BaseController *base = [[controller alloc] init];
    if ([(NSObject*)base respondsToSelector:@selector(setUserInfo:)])
    {
        base.userInfo = info;
        base.otherInfo = other;
        base.title = title;
        if (isModel)
        {
            CATransition *transition = [CATransition animation];
            transition.duration = 0.3f;
            transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
            transition.type = kCATransitionMoveIn;
            transition.subtype = kCATransitionFromTop;
            transition.delegate = self;
            [self.navigationController.view.layer addAnimation:transition forKey:nil];
        }
    }
    base.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:base animated:!isModel];
    return base;
}

//不需要Base来配置头部
- (BaseController*)pushController:(Class)controller withOnlyInfo:(id)info
{
    MyLog(@"Base UserInfo:%@",info);
    BaseController *base = [[controller alloc] init];
    if ([(NSObject*)base respondsToSelector:@selector(setUserInfo:)])
    {
        base.userInfo = info;
    }
    base.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:base animated:YES];
    return base;
}

- (BOOL)popController:(NSString*)controllerstr withSel:(SEL)sel withObj:(id)info
{
    BOOL pop = NO;
    for (id controller in self.navigationController.viewControllers)
    {
        if ([NSStringFromClass([controller class]) isEqualToString:controllerstr])
        {
            if ([(NSObject*)controller respondsToSelector:sel])
            {
                [controller performSelector:sel withObject:info afterDelay:0.01];
            }
            [self popController:controller];
            pop = YES;
            break;
        }
    }
    return pop;
}

- (void)popController:(id)controller
{
    //Class cls = NSClassFromString(controller);
    if ([controller isKindOfClass:[UIViewController class]])
    {
        [self.navigationController popToViewController:controller animated:YES];
    }
    else
    {
        MyLog(@"popToController NOT FOUND.");
        [self.navigationController popViewControllerAnimated:YES];
    }
}


//右边导航按钮
//1. 纯icon
//2. 纯文字，  保存...
-(void)setRightNavBtn:(NSString *)iconName title:(NSString *)titleStr withTarget:(SEL)sel
{
    UIButton *nextBtn;
    UIBarButtonItem *nextItem;
    if(iconName)           //1. 纯icon
    {
        nextBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        [nextBtn setImage:[UIImage imageNamed:iconName] forState:UIControlStateNormal];
        nextBtn.titleLabel.font = kFont(18);
        [nextBtn setTitleColor:[LibFun hexStringToColor:@"#ffffff"] forState:UIControlStateNormal];
    }
    else                   //2. 纯文字，  保存...
    {
        nextBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        [nextBtn setTitle:titleStr forState:(UIControlStateNormal)];
        [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        nextBtn.layer.cornerRadius = 5;
        nextBtn.frame=CGRectMake(0,0,60,40);
        nextBtn.titleLabel.font=kFont(18);
    }
    [nextBtn addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
    nextItem = [[UIBarButtonItem alloc] initWithCustomView:nextBtn];
    self.navigationItem.rightBarButtonItem = nextItem;
}

//自定义：左边导航按钮
//1. 纯icon          iconName: 图标素材的名字；selector：响应的事件
//2. icon + 文字  < 返回   nil, nil   都显示为nil
-(void)setLeftNavBtn:(NSString *)iconName withTarget:(SEL)sel
{
    UIButton *backButton;
    UIBarButtonItem *backItem;
    if ( iconName )                        //1. 显示图标
    {
        backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [backButton setFrame:CGRectMake(0, 0, 20, 20)];
        [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [backButton setTintColor:[UIColor whiteColor]];
        [backButton setImage:[UIImage imageNamed:iconName] forState:UIControlStateNormal];
        [backButton addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
    }
    else                                   //2. 返回
    {
        backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
        backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        backButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [backButton setImage:[UIImage imageNamed:@"back-icon"] forState:UIControlStateNormal];
        [backButton setTitle:@"返回" forState:UIControlStateNormal];
        backButton.titleLabel.font = kFont(18);
        [backButton setTitleColor:[LibFun hexStringToColor:@"#ffffff"] forState:UIControlStateNormal];
        [backButton addTarget:self.navigationController action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
    }
    backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    [self.navigationItem setLeftBarButtonItem:backItem];
}

//设置导航栏
-(BOOL)isHiddenNavBar
{
    return  NO;
}


/**
 * 颜色值转换
 **/
-(UIColor *)hexStringToColor: (NSString *) stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor blackColor];
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}



#pragma uigesture delegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return ![NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"];
}

-(void)onTap:(UITapGestureRecognizer *)tap
{
    [self.view endEditing:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //控制是否显示NavBar
    self.navigationController.navigationBar.hidden = [self isHiddenNavBar];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
