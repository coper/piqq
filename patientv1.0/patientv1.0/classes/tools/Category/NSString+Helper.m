//
//  NSString+Helper.m
//  Qikewang
//
//  Created by classjing on 14-1-24.
//  Copyright (c) 2014年 qike. All rights reserved.
//

#import "NSString+Helper.h"
#import <CommonCrypto/CommonDigest.h>
@implementation NSString (Helper)


#pragma mark 清空字符串中的空白字符
- (NSString *)trimString
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

#pragma mark 是否空字符串
- (BOOL)isEmptyString
{
    return (self.length == 0);
}

#pragma mark 返回沙盒中的文件路径
- (NSString *)documentsPath
{
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    return [path stringByAppendingPathComponent:self];
}

#pragma mark 写入系统偏好
- (void)saveToNSDefaultsWithKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setObject:self forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (NSString *)appendToDocumentDir
{
    NSString *docDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    
    return [docDir stringByAppendingPathComponent:self];
}
- (NSURL *)appendToDocumentURL
{
    return [NSURL fileURLWithPath:[self appendToDocumentDir]];
}

- (NSString *)base64EncodedString
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    return [data base64EncodedStringWithOptions:0];
}

- (NSString *)base64DecodeString
{
    NSData *data = [[NSData alloc] initWithBase64EncodedString:self options:0];
    
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

- (NSString *)appendDateTime
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *str = [formatter stringFromDate:[NSDate date]];
    
    return [NSString stringWithFormat:@"%@%@", self, str];
}


-(NSString*)appendStr:(NSString*)str
{
    return [NSString stringWithFormat:@"%@%@",self,str];
}

+ (NSString *)md5:(NSString *)str

{
    
    const char *cStr = [str UTF8String];
    
    unsigned char result[16];
    
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    
    return [NSString stringWithFormat:
            
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            
            result[0], result[1], result[2], result[3],
            
            result[4], result[5], result[6], result[7],
            
            result[8], result[9], result[10], result[11],
            
            result[12], result[13], result[14], result[15]
            
            ]; 
    
}

/**
 *  根据自己大小获取字符串的size
 *
 *  @param string 字符串
 *  @param font   字体
 *
 *  @return 返回size
 */
-(CGSize)getStringSizewithFont:(UIFont*)font withWidth:(CGFloat)width
{
    NSArray *arry = [self componentsSeparatedByString:@"\n"];
    float height = 0;
    float sx = 0;
    
    for (NSString *str in arry) {
        
        NSString *t = str;
        
//        if ([t isEqualToString:@""]) {
//            t = @" ";
//        }
        CGSize detailSize;
        
        NSDictionary *attrDic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
   
        detailSize = [t boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrDic context:nil].size;
        height += detailSize.height;
            
       
        sx = detailSize.width;
    }
    CGSize size = CGSizeMake(sx, height);
    return size;
}

-(BOOL)containsStr:(NSString *)str
{
    BOOL flag = YES;
    if ([self rangeOfString:str].location ==NSNotFound) {//如果不包含那么就为no
        flag = NO;
    }
    return flag;
}

@end
