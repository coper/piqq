//
//  DictionaryWithString.m
//  patient
//
//  Created by zhangyu on 15/6/4.
//  Copyright (c) 2015年 ASK. All rights reserved.
//

#import "DictionaryWithString.h"
#import "NSString+Helper.h"

@implementation DictionaryWithString
- (void)setValue:(id)value forKey:(NSString *)key
{
    if (!_mutaDictionary)
    {
        _mutaDictionary=[[NSMutableDictionary alloc] init];
    }
    if (!_md5TargetString)
    {
        _md5TargetString=[[NSMutableString alloc] initWithString:@""];
    }
    
    [_mutaDictionary setValue:value forKey:key];
    
    if ([NSString stringWithFormat:@"%@",value].length >500)
    {
        return;
    }
    _md5TargetString = [_md5TargetString appendStr:value];

}
@end
