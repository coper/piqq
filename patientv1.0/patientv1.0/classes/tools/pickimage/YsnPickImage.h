//
//  YsnPickImage.h
//  patientv1.0
//
//  Created by liyongli on 15/7/15.
//  Copyright (c) 2015年 ask. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <objc/message.h>
#import "LXActionSheet.h"


// 消息回调 objc_msgSend
//#define msgSend(...) ((void (*)(void *, SEL, NSObject *))objc_msgSend)(__VA_ARGS__)
//#define msgTarget(target) (__bridge void *)(target)



@interface YsnPickImage : UIViewController<UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate,LXActionSheetDelegate>

/**
 *  选择的监听器
 */
@property (weak, nonatomic) id selectWithTaget;
/**
 *  回调给选择图片的监听方法
 */
@property (assign, nonatomic) SEL selectBackImageAction;


/**
 *  添加一个选择选择按钮
 *
 *  @param target 目标
 *  @param action 回调方法
 */
- (void)addSelectWithTarget:(id)target action:(SEL)action;


/**
 *  处理选中的图片
 *  @param imageView 将图像显示在这里
 */
-(BOOL)makeAndSaveImage:(UIImageView *)imageimageView;


/**
 *  返回处理好的图像
 */
- (UIImage *)getSmallResultImage;

/**
 *  返回原始大图的图像
 */
- (UIImage *)getOrignalResultImage;

/**
 *  返回原始大图的图像的路径
 */
- (NSString *)getOrignalImagePath;

/**
 *  返回处理好的图像的路径
 */
- (NSString *)getSmallImagePath;

@end
