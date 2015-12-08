//
//  LibFun.m
//  wq
//
//  Created by liyongli on 14-4-18.
//  Copyright (c) 2014年 liyongli. All rights reserved.
//

#import "LibFun.h"
#import <CommonCrypto/CommonDigest.h>



@implementation LibFun


+(float) getColorByRGB: (float)a
{
    float r;
    r=(float)a/255;
    return r;
}


//将16进制的颜色值变成UIColor
+(UIColor *) colorFromHexRGB:(NSString *) inColorString
{
    UIColor *result = nil;
    unsigned int colorCode = 0;
    unsigned char redByte, greenByte, blueByte;
    
    if (nil != inColorString)
    {
        NSScanner *scanner = [NSScanner scannerWithString:inColorString];
        (void) [scanner scanHexInt:&colorCode]; // ignore error
    }
    redByte = (unsigned char) (colorCode >> 16);
    greenByte = (unsigned char) (colorCode >> 8);
    blueByte = (unsigned char) (colorCode); // masks off high bits
    result = [UIColor
              colorWithRed: (float)redByte / 0xff
              green: (float)greenByte/ 0xff
              blue: (float)blueByte / 0xff
              alpha:1.0];    
    return result;
}



//+(void) Alert:(NSString *) title message:(NSString *) message btnTitle:(NSString *) btnTitle
//{
//     alert= [[UIAlertView alloc] initWithTitle:title
//                                                    message:message
//                                                   delegate:nil
//                                          cancelButtonTitle:btnTitle
//                                          otherButtonTitles:nil];
//    [alert show];
//    [alert release];
//
//}

/**
 * 返回MD5
 **/
+(NSString *)getMD5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];

    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    
    return [[NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ] uppercaseString];
}



//- (NSString *) md5_base64
//{
//    const char *cStr = [str UTF8String];
//    unsigned char digest[CC_MD5_DIGEST_LENGTH];
//    CC_MD5( cStr, strlen(cStr), digest );
//    
//    NSData * base64 = [[NSData alloc]initWithBytes:digest length:CC_MD5_DIGEST_LENGTH];
//    base64 = [GTMBase64 encodeData:base64];
//    
//    NSString * output = [[NSString alloc] initWithData:base64 encoding:NSUTF8StringEncoding];
//    return output;
//}






/**
 * 返回当前的时间戳
 **/
+(NSString *)getNowTimeNum:(NSString *)format
{
//    if (format == nil)
//    {
//        format = @"yyyyMMddHHmmss";
//    }
//    //实例化一个NSDateFormatter对象
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    //设定时间格式,这里可以设置成自己需要的格式
////  [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    [dateFormatter setDateFormat:format];
//    //用[NSDate date]可以获取系统当前时间
//    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
//    //输出格式为：2010-10-27 10:22:13
//    NSLog(@"%@",currentDateStr);
//    //alloc后对不使用的对象别忘了release
//    return currentDateStr;
    

    if (format == nil)
    {
        format = @"yyyy-MM-dd hh:mm:ss.SSS";
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    
    //输出格式为：2010-10-27 10:22:13
    NSLog(@"%@",currentDateStr);
    //alloc后对不使用的对象别忘了release
    return currentDateStr;

}







+(NSString *)timeNumToDateStr:(NSString *)timeNumStr format:(NSString *)format
{
    NSString *currentDateStr;
    if (format == nil)
    {
        format = @"yyyy-MM-dd HH:mm:ss";
    }
    NSTimeInterval inte = [timeNumStr doubleValue];
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:inte];
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *zone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];//转为东八区
    [dateFormatter setTimeZone:zone];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:format];
    //用[NSDate date]可以获取系统当前时间
    currentDateStr = [dateFormatter stringFromDate:date];
    return currentDateStr;
}

/**
 * 验证邮件
 **/
+ (BOOL) validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

/**
 * 手机号
 **/
+ (BOOL) validateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}


/**
 * 验证车牌号
 **/
+ (BOOL) validateCarNo:(NSString *)carNo
{
    NSString *carRegex = @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    NSLog(@"carTest is %@",carTest);
    return [carTest evaluateWithObject:carNo];
}


/**
 * 验证车型
 **/
+ (BOOL) validateCarType:(NSString *)CarType
{
    NSString *CarTypeRegex = @"^[\u4E00-\u9FFF]+$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CarTypeRegex];
    return [carTest evaluateWithObject:CarType];
}


/**
 * 验证用户名
 **/
+ (BOOL) validateUserName:(NSString *)name
{
    NSString *userNameRegex = @"^[A-Za-z0-9]{6,20}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:name];
    return B;
}


/**
 * 验证密码
 **/
+ (BOOL) validatePassword:(NSString *)passWord
{
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,20}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passWord];
}


/**
 * 验证昵称
 **/
+ (BOOL) validateNickname:(NSString *)nickname
{
    NSString *nicknameRegex = @"^[0x4e00-0x9fa5]{6,8}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [passWordPredicate evaluateWithObject:nickname];
}


/**
 * 验证身份证
 **/
+ (BOOL) validateIdentityCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}


+(NSArray *)SortMutableArr:(NSMutableArray *)arr
{
    NSArray *sortedArray =[arr sortedArrayUsingFunction:sortByID context:nil];
    return sortedArray;
}

NSInteger sortByID(id obj1, id obj2, void *context)
{
    // ibj1  和 obj2 来自与你的数组中，其实，个人觉得是苹果自己实现了一个冒泡排序给大家使用
    NSString *str1 =(NSString*) obj1;
    NSString *str2 =(NSString *) obj2;
    
    if (str1.length < str2.length)
    {
        return NSOrderedDescending;
    }
    else if(str1.length == str2.length)
    {
        return NSOrderedSame;
    }
    return NSOrderedAscending;
}

//获取绝对坐标
+(CGRect) getGloabCGRect:(UIView *)currView targetView:(UIView *)targetView
{
    CGRect rc = [currView.superview convertRect:currView.frame toView:targetView];
    return rc;
}

/**
 * 颜色值转换
 **/
+(UIColor *)hexStringToColor: (NSString *) stringToConvert
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


/**
 * 打印日志
 */
+(void) logOut:(NSString *)msgStr
{
    NSLog(@"[Debug: %@ ]: %@", [LibFun getNowTimeNum:@"yyyy-MM-dd HH:mm:ss"], msgStr);
}

//+ (NSString*) fileSizeToString:(long long) fileSize{
//        NSInteger KB = 1024;
//       NSInteger MB = KB*KB;
//        NSInteger GB = MB*KB;
//        if (fileSize < 10) {
//                return @"无";
//            }else if (fileSize < KB) {
//                    return @"小于1KB";
//                }else if (fileSize < MB){
//                        return [NSString stringWithFormat:@"%.1f KB", ((CGFloat)fileSize)/KB];
//                    }else if (fileSize < GB) {
//                            return [NSString stringWithFormat:@"%.1f MB", ((CGFloat)fileSize)/MB];
//                        }else {
//                                return [NSString stringWithFormat:@"%.1f GB", ((CGFloat)fileSize)/GB];
//                            }
//}
//
//
//+ (long long) freeDiskSpaceInBytes{
//       struct statfs buf;
//       long long freespace = -1;
//        if(statfs("/var", &buf) >= 0){
//        freespace = (long long)(buf.f_bsize * buf.f_bfree);
//          }
//        return freespace;
//}


/**
 * 返回文件的大小：
 * fileSize:  NSString 字符串的长度
 * UIImage:   NSData * imageData = UIImageJPEGRepresentation(image,1);
 */
+(NSString*) fileSizeToString:(long) fileSize
{
    NSInteger KB = 1024;
    NSInteger MB = KB*KB;
    NSInteger GB = MB*KB;
    
    if (fileSize < 10)
    {
        return @"无";
    }
    else if (fileSize < KB)
    {
        return @"小于1KB";
    }
    else if (fileSize < MB)
    {
        return [NSString stringWithFormat:@"%.1f KB", ((CGFloat)fileSize)/KB];
    }
    else if (fileSize < GB)
    {
        return [NSString stringWithFormat:@"%.1f MB", ((CGFloat)fileSize)/MB];
    }
    else
    {
        return [NSString stringWithFormat:@"%.1f GB", ((CGFloat)fileSize)/GB];
    }
}

@end

