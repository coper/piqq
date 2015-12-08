//
//  LibuiFun.m
//  wq
//
//  Created by liyongli on 14-6-18.
//  Copyright (c) 2014年 liyongli. All rights reserved.
//


#import <QuartzCore/QuartzCore.h>
#import "LibuiFun.h"
#import "LibFun.h"


@implementation LibuiFun

/**
 * 显示加载进度
 * 没有半透明效果
 **/
+(UIView *)showLoadingView:(UIView *)parentView errorMsg:(NSString *)errorMsg
{
    //背景界面
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, parentView.frame.size.width,parentView.frame.size.height)];
    [parentView addSubview:bgView];
    
    //半透明背景界面
    UIView *alphaView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, parentView.frame.size.width,parentView.frame.size.height)];
    [bgView addSubview:alphaView];
//  alphaView.backgroundColor = [UIColor whiteColor];
//  alphaView.alpha = 0.3;
    
    UIView *blackView;
    UIActivityIndicatorView *activity;
    if (errorMsg)
    {
        //加载块
        blackView = [[UIView alloc]  initWithFrame:CGRectMake(0, 0, 100,100)];
        blackView.backgroundColor = [UIColor blackColor];
        blackView.alpha = 0.3;
        blackView.layer.cornerRadius = 10;
        blackView.layer.masksToBounds = YES;
        float bTmpX = (float)(parentView.frame.size.width - blackView.frame.size.width)*0.5;
        float bTmpY = (float)(parentView.frame.size.height - blackView.frame.size.height)*0.5;
        blackView.frame = CGRectMake(bTmpX, bTmpY, blackView.frame.size.width, blackView.frame.size.height);
        float tmpX = (float)(blackView.frame.size.width-30)*0.5;
        float tmpY = (float)(blackView.frame.size.height-45)*0.5;
        activity = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(tmpX, tmpY, 30, 30)];
        [activity setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];//设置进度轮显示类型
        [blackView addSubview:activity];
        [activity startAnimating];

        //声明UIlbel并指定其位置和长宽
        UILabel *userNameLab = [[UILabel alloc] initWithFrame:CGRectMake(0, activity.frame.origin.y + activity.frame.size.height*0.5 + 15, blackView.frame.size.width, 24)];
        userNameLab.backgroundColor = [UIColor clearColor];   //设置label的背景色，这里设置为透明色。
        userNameLab.text = errorMsg;                          //设置label所显示的文本
        userNameLab.font = [UIFont systemFontOfSize:14.0];
        UIColor *textColor = [UIColor colorWithRed:[LibFun getColorByRGB:255] green:[LibFun getColorByRGB:255] blue:[LibFun getColorByRGB:255] alpha:1.000];
        userNameLab.textColor = textColor;         //设置文本的颜色
        userNameLab.textAlignment = NSTextAlignmentCenter;
        [blackView addSubview:userNameLab];
    }
    else
    {
        //加载块
        blackView = [[UIView alloc]  initWithFrame:CGRectMake(0, 0, 80,80)];
        blackView.backgroundColor = [UIColor blackColor];
        blackView.alpha = 0.6;
        blackView.layer.cornerRadius = 10;
        blackView.layer.masksToBounds = YES;
        float bTmpX = (float)(parentView.frame.size.width - blackView.frame.size.width)*0.5;
        float bTmpY = (float)(parentView.frame.size.height - blackView.frame.size.height)*0.5;
        blackView.frame = CGRectMake(bTmpX, bTmpY, blackView.frame.size.width, blackView.frame.size.height);
        float tmpX = (float)(blackView.frame.size.width-30)*0.5;
        float tmpY = (float)(blackView.frame.size.height-30)*0.5;
        activity = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(tmpX, tmpY, 30, 30)];
        [activity setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];//设置进度轮显示类型
        [blackView addSubview:activity];
        [activity startAnimating];
    }
    [bgView addSubview:blackView];
    return bgView;
}

/**
 * 显示加载进度
 * 从下面飞出的效果
 **/
+(UIView *)showLoadingViewB:(UIView *)parentView errorMsg:(NSString *)errorMsg
{
    UIView *blackView = [[UIView alloc]  initWithFrame:CGRectMake(0, 0, parentView.frame.size.width - 100,40)];
    blackView.backgroundColor = [UIColor blackColor];
    blackView.alpha = 0.9;
    blackView.layer.cornerRadius = 3;
    blackView.layer.masksToBounds = YES;
    float bTmpX = (float)(parentView.frame.size.width - blackView.frame.size.width)*0.5;
    float bTmpY = (float)(parentView.frame.size.height - ROOT_VIEW_BOTTOM)- blackView.frame.size.height;
    blackView.frame = CGRectMake(bTmpX, bTmpY, blackView.frame.size.width, blackView.frame.size.height);
    
    //声明UIlbel并指定其位置和长宽
    UILabel *userNameLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, blackView.frame.size.width, 30)];
    userNameLab.backgroundColor = [UIColor clearColor];   //设置label的背景色，这里设置为透明色。
    userNameLab.text = errorMsg;                          //设置label所显示的文本
    userNameLab.font = [UIFont systemFontOfSize:14.0];
    UIColor *textColor = [UIColor colorWithRed:[LibFun getColorByRGB:255] green:[LibFun getColorByRGB:255] blue:[LibFun getColorByRGB:255] alpha:1.000];
    userNameLab.textColor = textColor;         //设置文本的颜色
    userNameLab.textAlignment = NSTextAlignmentCenter;
    [blackView addSubview:userNameLab];
    [parentView addSubview:blackView];
    
    [UIView
      animateWithDuration:0.2
      delay:0.0f
      options:UIViewAnimationOptionCurveEaseOut
      animations:^(void)
      {
         blackView.frame = CGRectMake(blackView.frame.origin.x, bTmpY - 50, blackView.frame.size.width, blackView.frame.size.height);
      }
      completion:^(BOOL finishedA)
      {
          [UIView
           animateWithDuration:0.1
           delay:3.0f
           options:UIViewAnimationOptionCurveEaseOut
           animations:^
           {
               blackView.alpha = 0;
           }
           completion:^(BOOL finishedB)
           {
               [blackView removeFromSuperview];
           }
           ];
      }
     ];
    return blackView;
}


/**
 * 显示出错信息
 **/
+(UIView *)showErrorView:(UIView *)parentView errorMsg:(NSString *)errorMsg
{
    UIView *baseView = [[UIView alloc]  initWithFrame:CGRectMake(0, TABVIEW_HEAD_HEIGHT, parentView.frame.size.width, parentView.frame.size.height)];
    
    float tmpX = (float)(parentView.frame.size.width-96)*0.5;
    float tmpY = (float)(parentView.frame.size.height-96)*0.5;
    UIImageView *errorImage = [[UIImageView alloc] initWithFrame:CGRectMake(tmpX, tmpY, 96, 96)];
    [baseView addSubview:errorImage];
    errorImage.image = [UIImage imageNamed:@"error"];
    CGRect rc = [LibFun getGloabCGRect:errorImage targetView:[LibuiFun getMainWindow]];
    
    errorImage.frame = CGRectMake(tmpX, rc.origin.y, 96, 96);
    //声明UIlbel并指定其位置和长宽
    UILabel *userNameLab = [[UILabel alloc] initWithFrame:CGRectMake(0, errorImage.frame.origin.y + errorImage.frame.size.height + 10, parentView.frame.size.width, 32)];
    userNameLab.backgroundColor = [UIColor clearColor];   //设置label的背景色，这里设置为透明色。
    userNameLab.text = errorMsg;                          //设置label所显示的文本
    userNameLab.font = [UIFont systemFontOfSize:16.0];
    UIColor *textColor = [UIColor colorWithRed:[LibFun getColorByRGB:70.0] green:[LibFun getColorByRGB:70.0] blue:[LibFun getColorByRGB:70.0] alpha:1.000];
    userNameLab.textColor = textColor;         //设置文本的颜色
    userNameLab.textAlignment = NSTextAlignmentCenter;
    [baseView addSubview:userNameLab];
    [parentView addSubview:baseView];
    baseView.backgroundColor = [UIColor whiteColor];
    return baseView;
}


+(void)goEffect:(UIView *)targetView frame:(CGRect) frame
{
    [UIView
     animateWithDuration:0.4
     delay:0.0f
     options:UIViewAnimationOptionCurveEaseOut
     animations:^(void)
     {
         targetView.frame = frame;
     }
     completion:^(BOOL finishedA)
     {
         
     }
     ];
}


// 获取最外层的window
+(UIWindow *)getMainWindow
{
    UIWindow *_window;
    NSEnumerator *frontToBackWindows = [UIApplication.sharedApplication.windows reverseObjectEnumerator];
    NSLog(@" frontToBackWindows  %@", frontToBackWindows);
    
    for (UIWindow *window in frontToBackWindows)
    {
        BOOL windowOnMainScreen = window.screen == UIScreen.mainScreen;
        BOOL windowIsVisible = !window.hidden && window.alpha > 0;
        BOOL windowLevelNormal = window.windowLevel == UIWindowLevelNormal;
        if (windowOnMainScreen && windowIsVisible && windowLevelNormal)
        {
            _window = window;
            break;
        }
    }
    return  _window;
}

@end
