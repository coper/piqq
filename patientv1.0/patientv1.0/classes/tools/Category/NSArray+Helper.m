//
//  NSArray+Helper.m
//  patient
//
//  Created by LZA on 15-4-9.
//  Copyright (c) 2015年 ASK. All rights reserved.
//

#import "NSArray+Helper.h"

@implementation NSArray (Helper)

/**
 *  讲数组转换成字符串
 *
 *  @return 字符串
 */
-(NSString*)arryToNSString
{
    NSMutableString *strM = [NSMutableString string];
    
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [strM appendFormat:@"%@", obj];
        
        if (idx < self.count - 1) {
            [strM appendString:@","];
        }
    }];
    //[strM appendString:@"\n)"];
    MyLog(@"%@",strM);
    return strM;
}


//- (NSString *)descriptionWithLocale:(id)locale
//{
//    NSMutableString *strM = [NSMutableString stringWithFormat:@"%d (\n", self.count];
//    
//    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//        [strM appendFormat:@"\t%@", obj];
//        
//        if (idx < self.count - 1) {
//            [strM appendString:@",\n"];
//        }
//    }];
//    [strM appendString:@"\n)"];
//    
//    return strM;
//}

@end
