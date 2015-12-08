//
//  UIImage+ZJ.h
//  Babytop
//
//  Created by 郑敬 on 14-5-10.
//  Copyright (c) 2014年 babytop. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ZJ)
#pragma mark 加载全屏的图片
+ (UIImage *)fullscrennImage:(NSString *)imgName;

#pragma mark 可以自由拉伸的图片
+ (UIImage *)resizedImage:(NSString *)imgName;

#pragma mark 可以自由拉伸的图片
+ (UIImage *)resizedImage:(NSString *)imgName xPos:(CGFloat)xPos yPos:(CGFloat)yPos;

#pragma mark 压缩图片
-(UIImage*)reduceImage;
#pragma mark 将图片转换成base64
-(NSString *)encodeToBase64String;

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
@end
