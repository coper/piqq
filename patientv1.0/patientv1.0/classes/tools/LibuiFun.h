//
//  LibuiFun.h
//  wq
//
//  Created by liyongli on 14-6-18.
//  Copyright (c) 2014年 liyongli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


/**
 *	@brief	页面的属性
 */
typedef enum
{
    TITLE_HEIGHT = 64,                /**标题高度*/
    ROOT_VIEW_WIDTH = 320,            /**宽度*/
    //ROOT_VIEW_HEIGHT = 480,           /**高度*/
    ROOT_VIEW_BOTTOM = 49,            /**底部高度*/
    TABVIEW_HEAD_HEIGHT = 54          /**tabview高度*/
}
ROOT_VIEW;

@interface LibuiFun : NSObject

+(UIView *) showErrorView:(UIView *)parentView errorMsg:(NSString *)errorMsg;
+(UIView *) showLoadingView:(UIView *)parentView errorMsg:(NSString *)errorMsg;
+(UIView *) showLoadingViewB:(UIView *)parentView errorMsg:(NSString *)errorMsg;

+(void)goEffect:(UIView *)targetView frame:(CGRect) frame;

@end
