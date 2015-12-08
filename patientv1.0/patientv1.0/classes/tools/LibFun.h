//
//  LibFun.h
//  wq
//
//  Created by liyongli on 14-4-18.
//  Copyright (c) 2014年 liyongli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LibFun : NSObject

/**
 *换算颜色值 根据rgb来计算 ios里需要的值
 **/
+ (float)getColorByRGB:(float)a;
+ (NSString *)getMD5:(NSString *)str;
+ (NSString *)getNowTimeNum:(NSString *)format;
+ (NSString *)timeNumToDateStr:(NSString *)timeNumStr format:(NSString *)format;
+ (BOOL) validateEmail:(NSString *)email;
+ (BOOL) validateNickname:(NSString *)nickname;
+ (BOOL) validatePassword:(NSString *)passWord;
+ (BOOL) validateUserName:(NSString *)name;
+ (BOOL) validateCarType:(NSString *)CarType;
+ (BOOL) validateCarNo:(NSString *)carNo;
+ (BOOL) validateMobile:(NSString *)mobile;
+ (BOOL) validateIdentityCard: (NSString *)identityCard;

//转换颜色值
+(UIColor *)hexStringToColor: (NSString *) stringToConvert;

//排序
+ (NSArray *)SortMutableArr:(NSMutableArray *)arr;
//获取绝对坐标
+(CGRect) getGloabCGRect:(UIView *) currView targetView:(UIView *) targetView;
/**
 * 打印日志
 */
+(void) logOut:(NSString *)msgStr;

/**
 * 返回文件的大小：
 * fileSize:  NSString 字符串的长度
 * UIImage :  NSData * imageData = UIImageJPEGRepresentation(image,1);
 */
+(NSString*) fileSizeToString:(long) fileSize;

@end
