//
//  HttpDefine.cpp
//  patient
//
//  Created by liyongli on 15/8/24.
//  Copyright (c) 2015年 ASK. All rights reserved.
//

#import "HttpDefine.h"

#define kBaseUrl          @"http://182.92.66.115:80"


@implementation HttpDefine

static NSString *IP;

+(void)setIp:(NSString *)ip
{
    IP=ip;
}
+(NSString *)getIp
{
    return IP;
}


+(NSString *)getURLPath:(NSString *)relativePath
{
    NSString *absolutePath;
    NSString *url;
    if (IP)
    {
        url = [NSString stringWithFormat:@"http://192.168.11.%@:8080",IP];
    }
    else
    {
        url = kBaseUrl;
    }
    absolutePath = [url stringByAppendingFormat:@"/askInterface/%@.ht",relativePath];
    return absolutePath;
}

@end